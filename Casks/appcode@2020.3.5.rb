cask "appcode@2020.3.5" do
  version "2020.3.5,203.8084.30"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2020.3.5.dmg"
      sha256 "7ee4b20cc97be32c633f432b213c7800fd0b97b5fd5cc2104ece4ec2aec1ef9d"
  else
      url "https://download.jetbrains.com/objc/AppCode-2020.3.5-aarch64.dmg"
      sha256 "07d94330fc86260227707b6ec53df1fb9c7e7e0b5b2e36bcd67950bde2555b36"
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