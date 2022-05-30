cask "appcode@2022.1.2" do
  version "2022.1.2,221.5787.30"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2022.1.2.dmg"
      sha256 "32865825514600d600e479317f446f4a60508308273745f8a1cb07bd93b4114b"
  else
      url "https://download.jetbrains.com/objc/AppCode-2022.1.2-aarch64.dmg"
      sha256 "b06797b2ded8ec26a72dbc1fa4d3192bbd1055af54121ccd0999258c413586ab"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "appcode") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/AppCode#{version.major_minor}",
    "~/Library/Caches/AppCode#{version.major_minor}",
    "~/Library/Logs/AppCode#{version.major_minor}",
    "~/Library/Preferences/AppCode#{version.major_minor}",
  ]
end