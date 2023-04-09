cask "pycharm-edu@2022.2.2" do
  version "2022.2.2,222.4345.35"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2022.2.2.dmg"
      sha256 "6902d330174b258cce1353343fd4ba2ccd7b6da1b3736d31a7cc3da6e41a93f4"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2022.2.2-aarch64.dmg"
      sha256 "fc25074308eb574eb4369c3a76c5d2625657ce854d6e1a8036f8ade967d5fd5e"
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