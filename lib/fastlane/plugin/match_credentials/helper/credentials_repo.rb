require 'fastlane_core/ui/ui'
require "fileutils"

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class CredentialsRepo
      def initialize(repo)
        @repo = File.join(repo, "credentials")
        FileUtils.mkdir_p @repo
      end

      def get_credential(key)
        path = File.join(@repo, key + ".credential")
        if !File.exists?(path) then
          UI.user_error!("No such key '#{key}' in the credentials repository")
        end
        File.read(path)
      end

      def set_credential(key, value)
        path = File.join(@repo, key + ".credential")
        IO.write(path, value)
        return path
      end
    end

  end
end
