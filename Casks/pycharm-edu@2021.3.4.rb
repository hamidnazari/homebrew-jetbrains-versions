cask "pycharm-edu@2021.3.4" do
  version "2021.3.4,213.7172.45"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2021.3.4.dmg"
      sha256 "f08400b7bf80b199b52749a2a34604de13a0a90156f028dd6b765aac284462f9"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2021.3.4-aarch64.dmg"
      sha256 "5b1ee2b696db6564598cd1c43f0a73a59dc2baa945ba93a07831fb5fb26d085f"
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
    "~/Library/Application Support/PyCharmEdu#{version.major_minor}",
    "~/Library/Caches/PyCharmEdu#{version.major_minor}",
    "~/Library/Logs/PyCharmEdu#{version.major_minor}",
    "~/Library/Preferences/PyCharmEdu#{version.major_minor}",
  ]
end