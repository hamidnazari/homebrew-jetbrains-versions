cask "pycharm-ce@2023.3.7" do
  version "2023.3.7,233.15619.17"

  name "JetBrains PyCharm Community Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-community-2023.3.7.dmg"
      sha256 "ae74047e0928236737b3482e7f17ac06245c56a6985cb0c672b90d51bb0e0a48"
  else
      url "https://download.jetbrains.com/python/pycharm-community-2023.3.7-aarch64.dmg"
      sha256 "19b14468c91fb7a8ee4fb3ee25e3f3c63621779bf9ae5299f4c77dc0e661a80c"
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