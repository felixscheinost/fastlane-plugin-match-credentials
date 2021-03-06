require "match"

describe Fastlane::Actions::MatchCredentialsAction do
  describe '#run' do
    it 'correctly decrypts the value' do
      values = {
        key: "test_credential"
      }
      config = FastlaneCore::Configuration.create(Fastlane::Actions::MatchCredentialsAction.available_options, values)
      ENV["MATCH_PASSWORD"] = "123"
      result = Fastlane::Actions::MatchCredentialsAction.run(config)
      expect(result).to eq("test_credential_value\n")
    end
  end
end
