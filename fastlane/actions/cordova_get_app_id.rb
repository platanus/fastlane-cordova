module Fastlane
  module Actions
    module SharedValues
      CORDOVA_APP_ID = :CORDOVA_APP_ID
    end

    class CordovaGetAppIdAction < Action
      def self.run(params)
        Actions.verify_gem!('nokogiri')
        require 'nokogiri'

        config_file = File.open(File.expand_path(params[:path]))
        config = Nokogiri::XML(config_file)
        config.at('widget').attribute('id').value
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Returns value from config.xml of your cordova project"
      end

      def self.details
        "This action let to get any value from the config.xml file." \
        "It will return a ruby object you can use."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "CORDOVA_GET_APP_ID_CONFIG_PATH",
                                       description: "Path to config file you want to read",
                                       optional: true,
                                       default_value: './config.xml',
                                       verify_block: proc do |value|
                                         unless File.exist?(File.expand_path(value))
                                           raise "Couldn't find config file at path '#{value}'".red
                                         end
                                       end)
        ]
      end

      def self.output
        [
          ['CORDOVA_APP_ID', 'Value for the key required from the config.xml file']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        ["platanus", "blackjid"]
      end

      # rubocop:disable Style/PredicateName
      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
      # rubocop:enable Style/PredicateName
    end
  end
end
