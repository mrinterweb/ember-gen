require 'erb'
require 'tilt'

module EmberGen
  class Generate

    # todo - need to figure out a way to read users preferences for 
    #        javascript engine and dependency management (AMD, common.js, ES6 module, global)
    #        then the correct template can be loaded.
    #        There are two likely places I can think that it would be good to load these files.
    #          1. config/environments/development.rb
    #          2. from an ember-gen specific configuration file 
    #             I don't really like this approach, as much be it is more agnostic
    TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'templates')

    def initialize(type, options={})
      @type = type
      @options = options
      load_template
    end

    def render
      # look at tilt for this
    end

    def print_template
      puts @template_file
    end

    private

    def load_template
      @template_file = File.read File.join(TEMPLATE_PATH, "#{@type}_test.coffee.erb")
    end

  end
end
