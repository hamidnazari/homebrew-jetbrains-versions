cask "pycharm-ce@2024.2" do
  version "2024.2,242.20224.347"

  name "JetBrains PyCharm Community Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-community-2024.2.dmg"
      sha256 "93e022c8d3b6ad95d720d54514d28518fe966c1ea4e5c3ed064d8688627cd16f"
  else
      url "https://download.jetbrains.com/python/pycharm-community-2024.2-aarch64.dmg"
      sha256 "f3ba2ad95cb227b7a6d83542d883008bd647fd000d798df68ea1994bc774fa15"
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