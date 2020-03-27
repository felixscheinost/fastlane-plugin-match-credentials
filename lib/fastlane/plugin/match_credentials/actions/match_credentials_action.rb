require 'fastlane/action'
require_relative '../helper/match_credentials_helper'
require_relative '../helper/options'

module Fastlane
  module Actions
    class MatchCredentialsAction < Action
      def self.run(params)
        Helper::MatchCredentialsHelper.run_with_repo(params) do |repo|
          repo = Helper::CredentialsRepo.new(repo.working_directory)
          repo.get_credential(params.fetch(:key))
        end
      end

      def self.description
        "Get credential from the match git repository"
      end

      def self.authors
        ["Felix Scheinost"]
      end

      def self.return_value
        "The decrypted value"
      end

      def self.available_options
        Helper::MatchCredentialsOptions.shared_options
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
