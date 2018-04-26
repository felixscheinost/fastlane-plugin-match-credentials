describe Fastlane::Actions::MatchCredentialsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The match_credentials plugin is working!")

      Fastlane::Actions::MatchCredentialsAction.run(nil)
    end
  end
end
