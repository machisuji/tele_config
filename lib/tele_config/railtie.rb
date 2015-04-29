require 'tele_config'
require 'rails'

module TeleConfig
  class Railtie < Rails::Railtie
    def show_usage
      puts "Usage: rake tele_config[uri,config/configuration.yml,MY_CONFIG]"
      puts
      puts "Which will download whatever URI is defined in the environment variable "
      puts "MY_CONFIG_URI to `config/configuration.yml`."
    end

    rake_tasks do
      desc 'Downloads the configuration file using the given source and parameters.'
      task :tele_config, [:source, :destination, :prefix] => :environment do |_, args|
        if args.empty?
          show_usage
        else
          prefix = args[:prefix] || TeleConfig::ENV_PREFIX

          TeleConfig.download args[:source], args[:destination], prefix: prefix
        end
      end
    end
  end
end
