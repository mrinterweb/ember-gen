
module EmberGen
  class Generate

    # todo - need to figure out a way to read users preferences for 
    #        javascript engine and dependency managment (AMD, common.js, ES6 module, global)
    #        then the correct template can be loaded.
    TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'templates')

    def initialize(type)
      @type = type
      load_template
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
