module Fastlane
  module Helper
    class MatchCredentialsOptions
      def self.shared_options
        [
          FastlaneCore::ConfigItem.new(key: :key,
                                      env_name: "MATCH_CREDENTIALS_KEY",
                                      description: "The key to get or set",
                                      optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :shallow_clone,
                                     env_name: "MATCH_SHALLOW_CLONE",
                                     description: "Make a shallow clone of the repository (truncate the history to 1 revision)",
                                     is_string: false,
                                     default_value: false),
          FastlaneCore::ConfigItem.new(key: :git_url,
                                     env_name: "MATCH_GIT_URL",
                                     description: "URL to the git repo containing all the certificates",
                                     optional: false,
                                     short_option: "-r"),
          FastlaneCore::ConfigItem.new(key: :git_branch,
                                     env_name: "MATCH_GIT_BRANCH",
                                     description: "Specific git branch to use",
                                     default_value: 'master'),
          FastlaneCore::ConfigItem.new(key: :clone_branch_directly,
                                     env_name: "MATCH_CLONE_BRANCH_DIRECTLY",
                                     description: "Clone just the branch specified, instead of the whole repo. This requires that the branch already exists. Otherwise the command will fail",
                                     is_string: false,
                                     default_value: false)
        ]
      end
    end
  end
end
