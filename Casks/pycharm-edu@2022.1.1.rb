cask "pycharm-edu@2022.1.1" do
  version "2022.1.1,221.5591.62"

  name "JetBrains PyCharm Educational Edition #{version.before_comma}"
  desc "Python IDE"
  homepage "https://www.jetbrains.com/pycharm-edu/"

  app "PyCharm Edu.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/python/pycharm-edu-2022.1.1.dmg"
      sha256 "b27a1ebff26e341570ffcae4dce8a5124c6d904667ceac51d02d0ccd9e6b8903"
  else
      url "https://download.jetbrains.com/python/pycharm-edu-2022.1.1-aarch64.dmg"
      sha256 "b68584964badfb0241b27f71898f9a797ede86e69ade1b6228bceab8db1c1bde"
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