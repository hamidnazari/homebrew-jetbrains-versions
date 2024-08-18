cask "pycharm-ce@2024.1.6" do
  version "2024.1.6,241.19072.16"

  name "JetBrains PyCharm Community Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-community-2024.1.6.dmg"
      sha256 "312642e62a5eff93a82f4bc966f56fc1f0dd0f03a463a4dc0d3b2828e265e739"
  else
      url "https://download.jetbrains.com/python/pycharm-community-2024.1.6-aarch64.dmg"
      sha256 "429adfc20cf1a99e1f34b8c5447d9a54c6d423283ebbc273148b2db2b4c9ae99"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "charm") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/PyCharm#{version.major_minor}",
    "~/Library/Caches/JetBrains/PyCharmCE#{version.major_minor}",
    "~/Library/Caches/PyCharm#{version.major_minor}",
    "~/Library/Caches/PyCharmCE#{version.major_minor}",
    "~/Library/Logs/JetBrains/PyCharmCE#{version.major_minor}",
    "~/Library/Logs/PyCharm#{version.major_minor}",
    "~/Library/Logs/PyCharmCE#{version.major_minor}",
    "~/Library/Preferences/PyCharm#{version.major_minor}",
    "~/Library/Preferences/PyCharmCE#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.pycharm.savedState",
  ]
end