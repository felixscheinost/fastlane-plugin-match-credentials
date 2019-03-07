require "match"

module Fastlane
  module Helper
    # The iterate method in the superclass only decripts cer, p12 and mobileprovision
    # Override this method to only decrypt our custom .credential files
    class CredentialsEncrypt < Match::Encryption::OpenSSL
      def iterate(source_path)
        Dir[File.join(source_path, "**", "*.{credential}")].each do |path|
          next if File.directory?(path)
          yield(path)
        end
      end
    end
  end
end
