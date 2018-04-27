require 'fastlane_core/ui/ui'
require "fileutils"
require "match"

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class MatchCredentialsHelper
      def self.runWithRepo(params)
        return if !block_given?

        load_matchfile(params)

        decrypted_repo = Match::GitHelper.clone(params.fetch(:git_url),
                                                params.fetch(:shallow_clone),
                                                branch: params.fetch(:git_branch),
                                                clone_branch_directly: params.fetch(:clone_branch_directly))
        Helper::CredentialsEncrypt.new.decrypt_repo(path: decrypted_repo, git_url: params[:git_url])

        return_value = yield(params, decrypted_repo)
        FileUtils.rm_rf(decrypted_repo)
        # Workaround, force GitHelper to clone again so that we can delete the directory
        Match::GitHelper.class_exec { @dir = nil }
        return return_value
      end

      def self.load_matchfile(intoParams) 
        matchfile = FastlaneCore::Configuration.create(Match::Options.available_options, {})
        matchfile.load_configuration_file("Matchfile")
        intoParams.available_options.each do |o|
          next if !matchfile.available_options.collect(&:key).include?(o.key)
          intoParams[o.key] = matchfile[o.key]
        end
      end
    end
  end
end
