require 'fastlane_core/ui/ui'
require "fileutils"
require "match"

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class MatchCredentialsHelper
      def self.runWithRepo(params)
        return if !block_given?
        params.load_configuration_file("Matchfile")
        # symentis: Clear GIT_TEMPLATE_DIR env var so the symentis hooks are not installed
        ENV.delete("GIT_TEMPLATE_DIR")
        decrypted_repo = Match::GitHelper.clone(params.fetch(:git_url),
                                                params.fetch(:shallow_clone),
                                                branch: params.fetch(:git_branch),
                                                clone_branch_directly: params.fetch(:clone_branch_directly))

        Helper::CredentialsEncrypt.new.decrypt_repo(path: decrypted_repo, git_url: params[:git_url])

        return_value = yield(params, decrypted_repo)

        FileUtils.rm_rf(decrypted_repo)
        return return_value
      end
    end
  end
end
