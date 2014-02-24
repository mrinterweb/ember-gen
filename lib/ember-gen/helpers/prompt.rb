require 'embergen/helpers/color'

module EmberGen
  module Helpers
    class Prompt
      include Color
      class InvalidResponse < StandardError; end
      class EmptyResponse < StandardError; end
    
      def initialize(question, color=nil, options={})
        @question = question
        @color = color || :yellow
        @options = options
      end
    
      def yes_no(options={})
        set_options(options)
        accepted_answers = %w[yes no y n]
        answer = ask do
          validate(prompt, accepted_answers)
        end
        %w[y yes].include?(answer)
      end
    
      # for some reason HighLine verify was not working so I wrote this
      def ask_and_verify(conditions=nil, options={})
        set_options(options)
        conditions ||= @options[:conditions]
        ask do
          if conditions.kind_of?(Array)
            putsc "available selections:"
            conditions.each_with_index do |con, i|
              putsc "#{i+1}: #{con}"
            end
          end
          validate(prompt, conditions)
        end
      end
    
      def ask(options={}, &block)
        set_options(options)
        default = @options[:default]
        max_retry = 5
        default_str = default ? " |#{default}|" : ""
        begin
          putsc @question+default_str, @color
          yield
        rescue InvalidResponse => e
          max_retry -= 1
          if max_retry > 0
            putsc @options[:error] || e.message
            retry
          else
            putsc "you may be confused. Get your head straight", :red
            exit 1
          end
        end
      end
    
      private
    
      def prompt
        Readline.readline
      end
    
      def putsc(str, color_sym=:yellow)
        puts color(str, color_sym)
      end
    
      def validate(answer, accepted_answers)
        return @options[:default] if answer.blank? and @options[:default]
        case accepted_answers.class.name
        when 'Regexp'
          unless answer =~ accepted_answers
            raise InvalidResponse, "Answer must match format #{accepted_answers}"
          end
        when 'Array'
          if answer.kind_of?(String) && answer =~ /^[0-9]+$/
            answer = accepted_answers[answer.to_i - 1] 
          end
          unless accepted_answers.include?(answer)
            raise InvalidResponse, "Please answer with one of the following: #{accepted_answers.join(', ')}"
          end
        else
          raise "unexpected accepted_answers type: #{accepted_answers.class.name}"
        end
        answer
      end
    
      def set_options(options)
        if !options.empty? || @options.nil?
          @options = options
        end
      end
    end

  end
end
