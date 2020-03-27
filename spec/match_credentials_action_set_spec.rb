require "match"

describe Fastlane::Actions::MatchCredentialsSetAction do
  describe '#run' do
    it 'correctly encrypts the value' do
      Dir.mktmpdir do |tmp_origin|
        system("git clone --bare https://github.com/felixscheinost/fastlane-plugin-match-credentials #{tmp_origin}")
        values = {
          git_url: "file:///" + tmp_origin,
          key: "test_credential2",
          value: "test_credential2_value"
        }
        ENV["MATCH_PASSWORD"] = "123"
        config = FastlaneCore::Configuration.create(Fastlane::Actions::MatchCredentialsSetAction.available_options, values)
        Fastlane::Actions::MatchCredentialsSetAction.run(config)
        Dir.chdir(tmp_origin) do
          expect(`git log -1 --pretty=%B`.strip).to eq("[fastlane][match_credentials] Set credential 'test_credential2'")
        end
      end
    end
  end
end
