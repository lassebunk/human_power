require 'rails/generators'

module HumanPower
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc "Creates a sample configuration file in config/robots.rb"
    def create_config_file
      copy_file "robots.rb", "config/robots.rb"
    end
  end
end