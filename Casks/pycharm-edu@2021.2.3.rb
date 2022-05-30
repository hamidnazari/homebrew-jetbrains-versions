cask "pycharm-edu@2021.2.3" do
  version "2021.2.3,212.5457.63"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2021.2.3.dmg"
      sha256 "2ce7877299d7e218323cd3bb97fc44b05bc54467bfffc25b46bbcffa97caace6"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2021.2.3-aarch64.dmg"
      sha256 "0bb8d3407ef1e0fa4502dc750997b707d47c56d1c621256cecabf80637dc8996"
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