cask "pycharm-edu@2020.3.4" do
  version "2020.3.4,203.7717.76"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2020.3.4.dmg"
      sha256 "bbb7db6c53a16024d8074a5b3263edf9892451c7e4b2021ce7d796654412404c"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2020.3.4-aarch64.dmg"
      sha256 "3e8ab7d1eab2a2a136bc512368cac5ff1478a193e66231ef33800ca72c55f3c0"
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