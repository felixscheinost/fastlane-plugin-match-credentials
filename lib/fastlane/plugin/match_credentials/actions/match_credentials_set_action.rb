require 'fastlane/action'
require_relative '../helper/match_credentials_helper'
require_relative '../helper/options'
module Fastlane
  module Actions
    class MatchCredentialsSetAction < Action
      def self.run(params)
        Helper::MatchCredentialsHelper.run_with_repo(params) do |repo|
          key = params.fetch(:key)
          modified_file = Helper::CredentialsRepo.new(repo.working_directory).set_credential(key, params.fetch(:value))

          # need to manually encrypt because GitHelper and Encrypt only encrypt .cer .p12 and .mobileprovision
          Helper::CredentialsEncrypt.new(
            keychain_name: params[:git_url],
            working_directory: repo.working_directory
          ).encrypt_files

          repo.upload_files(files_to_upload: [modified_file], custom_message: "[fastlane][match_credentials] Set credential '#{key}'")
        end
      end

      def self.description
        "Store credential in the match git repository"
      end

      def self.authors
        ["Felix Scheinost"]
      end

      def self.return_value
        ""
      end

      def self.available_options
        Helper::MatchCredentialsOptions.shared_options +
          [
            FastlaneCore::ConfigItem.new(key: :value,
                            env_name: "MATCH_CREDENTIALS_VALUE",
                            description: "The value to set",
                            optional: false,
                            type: String)
          ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
