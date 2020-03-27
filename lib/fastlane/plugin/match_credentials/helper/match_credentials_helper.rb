require 'fastlane_core/ui/ui'
require "fileutils"
require "match"

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    # Provides a way to run a block on the unencrypted repo
    # decrypts it before and deletes it after
    class MatchCredentialsHelper
      def self.run_with_repo(params)
        return unless block_given?

        load_matchfile(params)

        # COPIED FROM match/runner.rb
        # Choose the right storage and encryption implementations
        storage = Match::Storage.for_mode("git", {
          git_url: params[:git_url],
          shallow_clone: params[:shallow_clone],
          # skip_docs: params[:skip_docs],
          git_branch: params[:git_branch],
          # git_full_name: params[:git_full_name],
          # git_user_email: params[:git_user_email],
          clone_branch_directly: params[:clone_branch_directly],
          # type: params[:type].to_s,
          # platform: params[:platform].to_s,
          # google_cloud_bucket_name: params[:google_cloud_bucket_name].to_s,
          # google_cloud_keys_file: params[:google_cloud_keys_file].to_s,
          # google_cloud_project_id: params[:google_cloud_project_id].to_s
        })
        storage.download

        # Init the encryption only after the `storage.download` was called to have the right working directory
        encryption = Helper::CredentialsEncrypt.new(
          keychain_name: params[:git_url],
          working_directory: storage.working_directory
        )
        encryption.decrypt_files if encryption

        return_value = yield(storage)

        FileUtils.rm_rf(storage.working_directory)

        return return_value
      end

      def self.load_matchfile(into_params)
        matchfile = FastlaneCore::Configuration.create(Match::Options.available_options, {})
        matchfile.load_configuration_file("Matchfile")
        matchfile_options = matchfile.available_options.collect(&:key)
        into_params.available_options.each do |o|
          next unless matchfile_options.include?(o.key)
          into_params[o.key] = matchfile[o.key]
        end
      end
    end
  end
end
