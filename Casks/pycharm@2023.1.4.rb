cask "pycharm@2023.1.4" do
  version "2023.1.4,231.9225.15"

  name "JetBrains PyCharm #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-professional-2023.1.4.dmg"
      sha256 "04945795cdee1fb36a5c19c2846203bcc4bccba8939f58dd1265651578f9c4c6"
  else
      url "https://download.jetbrains.com/python/pycharm-professional-2023.1.4-aarch64.dmg"
      sha256 "7c86ed350d71b2fef5f1992a377e7fe161c38a3de91bc1f3bad0d9aafbcde6a8"
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