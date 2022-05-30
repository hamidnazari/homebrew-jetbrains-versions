cask "pycharm-edu@2021.1.3" do
  version "2021.1.3,211.7628.48"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2021.1.3.dmg"
      sha256 "5d910d1d81417dc117c964f6cb3adcda66df7dc1c8e77a6cef2050c094817872"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2021.1.3-aarch64.dmg"
      sha256 "70bf84f6d006d39eeb0e9c0cbba93fb683baa67bbe0339dffc03d7351c21bf12"
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