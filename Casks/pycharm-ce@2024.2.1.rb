cask "pycharm-ce@2024.2.1" do
  version "2024.2.1,242.21829.153"

  name "JetBrains PyCharm Community Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm/"

  app "PyCharm CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-community-2024.2.1.dmg"
      sha256 "bfc1f6d282ef67b62385f48cc119743de15e2776ec8cbe0cfe938a51b89e54b4"
  else
      url "https://download.jetbrains.com/python/pycharm-community-2024.2.1-aarch64.dmg"
      sha256 "479cfd05514df177bca56cf3406a944ef6bbdbdffb78adddec024e7209a7452f"
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