require "match"

module Fastlane
  module Helper
    class CredentialsEncrypt < Match::Encrypt
      def iterate(source_path)
        Dir[File.join(source_path, "**", "*.{credential}")].each do |path|
          next if File.directory?(path)
          print(path)
          yield(path)
        end
      end
    end
  end
end
