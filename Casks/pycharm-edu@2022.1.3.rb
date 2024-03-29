cask "pycharm-edu@2022.1.3" do
  version "2022.1.3,221.6008.17"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2022.1.3.dmg"
      sha256 "9ab4087c65c315cc095a882221b3748bc66b3b9f6699563cde02a49f857ee4d0"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2022.1.3-aarch64.dmg"
      sha256 "46e498610a3a026ebaa3269c5cc35fd9e75bf35dca4d45d739828036059edad1"
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