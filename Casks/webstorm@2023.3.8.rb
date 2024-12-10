cask "webstorm@2023.3.8" do
  version "2023.3.8,233.15619.15"

  name "JetBrains WebStorm #{version.before_comma}"
  desc "JavaScript IDE"
  homepage "https://www.jetbrains.com/webstorm/"

  app "WebStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webstorm/WebStorm-2023.3.8.dmg"
      sha256 "4c06fbaad419a3b5150592347e404f4507d230d9fe4ec09e5aed90818f7e92e5"
  else
      url "https://download.jetbrains.com/webstorm/WebStorm-2023.3.8-aarch64.dmg"
      sha256 "d9a3b0e43fb61901e64e8f73bb073cda9a3d2695e9f26cf380e4db81fb96ef73"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "wstorm") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/WebStorm#{version.major_minor}",
    "~/Library/Caches/JetBrains/WebStorm#{version.major_minor}",
    "~/Library/Logs/JetBrains/WebStorm#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.WebStorm.plist",
    "~/Library/Preferences/jetbrains.webstorm.*.plist",
    "~/Library/Preferences/WebStorm#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.WebStorm.savedState",
  ]
end