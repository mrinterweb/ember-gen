require 'pry'
require 'ember-gen/support'

namespace :embergen do
  namespace :update do
    include EmberGen::Support::FileSupport
    
    desc "upgrade ember.js and ember-data.js files takes optional argument of release, stable, canary"
    task :upgrade_ember, :version do |t, args|
      release = args[:version] || 'release'
      detect_version = ->(file) { File.readlines(file).detect { |l| l =~ /@version/ } }
  
      ember_path = './vendor/scripts/ember.js'
  
      if File.exists?(ember_path)
        puts "Existing ember version: #{detect_version.call(File.open(ember_path, 'r'))}"
      end
  
      %w[ember.js ember.min.js ember.prod.js ember-data.js ember-data.prod.js ember-data.min.js].each do |file_name|
        url = "http://builds.emberjs.com/#{release}/#{file_name}"
        download_and_move(url, "./vendor/scripts/#{file_name}")
        if file_name == 'ember.js'
          ember_file = File.open("./vendor/scripts/#{file_name}", 'r')
          puts "Downloaded version: #{detect_version.call(ember_file)}"
        end
      end
    end
  
  end
  
  namespace :install do
    include EmberGen::Support
    
    desc "install latest jquery 1.x"
    task "jquery_1x", :option do |t, args|
      task('install:jquery').invoke('1x', args[:option])
    end
  
    desc "install latest jquery 2.x"
    task "jquery_2x", :option do |t, args|
      puts 'jquery_2x task called'
      task('install:jquery').invoke('2x', args[:option])
    end
  
    desc "install specific version of jquery"
    task :jquery, :version, :option do |t, args|
      puts 'jquery task called'
      puts args.inspect
      version = args[:version]
      option = args[:option]
      option = 'uncompressed' unless %w[uncompressed minified].include?(option)
  
      conf = EmberGen::Support::Config.new(:vendor_map)
  
      begin
        url = conf.hash['jquery'][version][option]
      rescue
        begin
          url = conf.hash['jquery']['generic'][option]
          url.sub!('<version>', version)
        rescue NoMethodError
          raise "unable to find jquery with: version -> #{version}, option -> #{option}"
        end
      end
      download_and_move(url, "./vendor/assets/javascripts/jquery.js")
    end
  end

end # embergen namespace
