cask "pycharm@2023.2.5" do
  version "2023.2.5,232.10227.11"

  name "JetBrains PyCharm #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-professional-2023.2.5.dmg"
      sha256 "a8fbd5fda39cf94ccf86918fe170bcd74595e0d59491b79c329033d0e517ae2d"
  else
      url "https://download.jetbrains.com/python/pycharm-professional-2023.2.5-aarch64.dmg"
      sha256 "ee1e255047a5cf452c6f4e7b981f27edcf8bd7efa3be51e7d75d2defe63c5105"
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