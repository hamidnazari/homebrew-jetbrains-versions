cask "pycharm@2024.2.5" do
  version "2024.2.5,242.24807.21"

  name "JetBrains PyCharm #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-professional-2024.2.5.dmg"
      sha256 "6e79f13e98dec53b0f70a512a80ee3a46ce9ea9bcb083e29cff52c6a2d73e77f"
  else
      url "https://download.jetbrains.com/python/pycharm-professional-2024.2.5-aarch64.dmg"
      sha256 "27ab7ddaa5a899f8c1265428e297752777d3c9a1e53f2d9bbcfa72e3cdfd3ed9"
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
    "~/Library/Application Support/JetBrains/PyCharm#{version.major_minor}",
    "~/Library/Application Support/PyCharm#{version.major_minor}",
    "~/Library/Caches/JetBrains/PyCharm#{version.major_minor}",
    "~/Library/Logs/JetBrains/PyCharm#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.pycharm.plist",
    "~/Library/Preferences/jetbrains.pycharm.*.plist",
    "~/Library/Preferences/PyCharm#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.pycharm.savedState",
  ]
end