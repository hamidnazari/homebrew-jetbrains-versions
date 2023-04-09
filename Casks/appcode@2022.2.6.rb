cask "appcode@2022.2.6" do
  version "2022.2.6,222.4554.15"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2022.2.6.dmg"
      sha256 "e9cd19d0803b0ad471e7ab2ac9806b0af1ead03e2c01b1ac9e952861a88c216f"
  else
      url "https://download.jetbrains.com/objc/AppCode-2022.2.6-aarch64.dmg"
      sha256 "181eee7bbff0dcc6322cee8103fedfc7090aa2ea35d8f1d38e68b6f3a57da5e1"
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