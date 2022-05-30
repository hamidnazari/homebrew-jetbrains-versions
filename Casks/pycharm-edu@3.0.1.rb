cask "pycharm-edu@3.0.1" do
  version "3.0.1,162.2465"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  url "https://download.jetbrains.com/python/pycharm-edu-3.0.1.dmg"
  sha256 "34f6f1003cee6b2612c69b07dac1b0319899a93a6da928b15d3ab5c882bcd14e"

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "charm") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/PyCharmEdu#{version.major_minor}",
    "~/Library/Caches/PyCharmEdu#{version.major_minor}",
    "~/Library/Logs/PyCharmEdu#{version.major_minor}",
    "~/Library/Preferences/PyCharmEdu#{version.major_minor}",
  ]
end