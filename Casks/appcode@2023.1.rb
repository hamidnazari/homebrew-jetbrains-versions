cask "appcode@2023.1" do
  version "2023.1,231.8109.217"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2023.1.dmg"
      sha256 "405bd0caeaae754ca670636663f9a6a4f77aaa2d7a8dcd4873d7c134efbacae7"
  else
      url "https://download.jetbrains.com/objc/AppCode-2023.1-aarch64.dmg"
      sha256 "19f63d2c0af3cadc889ab5fe17889e03ddb2b0b2235f1cfbbe485072486d1aa1"
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