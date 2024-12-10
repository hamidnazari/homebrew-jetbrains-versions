cask "pycharm@2023.3.7" do
  version "2023.3.7,233.15619.17"

  name "JetBrains PyCharm #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-professional-2023.3.7.dmg"
      sha256 "c452c2f57240a34743c154d07e8a8e1b7bf4100890e1a0ba04de0e8c3ed1e21c"
  else
      url "https://download.jetbrains.com/python/pycharm-professional-2023.3.7-aarch64.dmg"
      sha256 "57a4e082e8ed9d859a992e1034aa1e4895e7a5145662c1b215fb4d8caf2e3fc2"
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