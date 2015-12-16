module Fastlane
  module Actions
    module SharedValues
      CORDOVA_GET_APP_ID_CUSTOM_VALUE = :CORDOVA_GET_APP_ID_CUSTOM_VALUE
    end

    class CordovaGetAppIdAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        Helper.log.info "Parameter API Token: #{params[:api_token]}"

        app_id = File.open('../config.xml').read.match(/widget id=\"([^"]*)\"/)[1]a

        Actions.lane_context[SharedValues::CORDOVA_GET_APP_ID_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your change to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "FL_CORDOVA_GET_APP_ID_API_TOKEN", # The name of the environment variable
                                       description: "API Token for CordovaGetAppIdAction", # a short description of this parameter
                                       verify_block: proc do |value|
                                          raise "No API token for CordovaGetAppIdAction given, pass using `api_token: 'token'`".red unless (value and not value.empty?)
                                          # raise "Couldn't find file at path '#{value}'".red unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: "FL_CORDOVA_GET_APP_ID_DEVELOPMENT",
                                       description: "Create a development certificate instead of a distribution one",
                                       is_string: false, # true: verifies the input is a string, false: every kind of value
                                       default_value: false) # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['CORDOVA_GET_APP_ID_CUSTOM_VALUE', 'The value of the last plist file that was parsed']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
