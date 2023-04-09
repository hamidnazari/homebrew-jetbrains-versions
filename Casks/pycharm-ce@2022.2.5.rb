cask "pycharm-ce@2022.2.5" do
  version "2022.2.5,222.4554.11"

  name "JetBrains PyCharm Community Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-community-2022.2.5.dmg"
      sha256 "1f85159a94f9f23a9e439abd1a6a3bdb5690375c8b854e3161818164944b39ca"
  else
      url "https://download.jetbrains.com/python/pycharm-community-2022.2.5-aarch64.dmg"
      sha256 "39b48b6f3a197705ccf9029ffb9e28f3345785205dacc12ef25c426b4aa8a72b"
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