cask "pycharm@2023.2.8" do
  version "2023.2.8,232.10335.17"

  name "JetBrains PyCharm #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-professional-2023.2.8.dmg"
      sha256 "787a5764fb24540906a029635cebb3c1c32866d0290f7c6164109b960bb44db3"
  else
      url "https://download.jetbrains.com/python/pycharm-professional-2023.2.8-aarch64.dmg"
      sha256 "b0cf82bd544ef2f60487b7ac8e4b7a884326a1b772e688615e79176df6bedccf"
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