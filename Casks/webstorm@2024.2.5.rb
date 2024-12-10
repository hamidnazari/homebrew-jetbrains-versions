cask "webstorm@2024.2.5" do
  version "2024.2.5,242.24807.6"

  name "JetBrains WebStorm #{version.before_comma}"
  desc "JavaScript IDE"
  homepage "https://www.jetbrains.com/webstorm/"

  app "WebStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webstorm/WebStorm-2024.2.5.dmg"
      sha256 "17252f18d078f2e0197c7b5393e4dfae1085e30c6328e3f984deb02b32ceca7a"
  else
      url "https://download.jetbrains.com/webstorm/WebStorm-2024.2.5-aarch64.dmg"
      sha256 "d7a35f353f5f99d5e4e76abdddb3a1d93da2da13257e1698eb6bb17ed8ee5a16"
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