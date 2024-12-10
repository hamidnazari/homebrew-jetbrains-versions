cask "webstorm@2023.2.8" do
  version "2023.2.8,232.10335.13"

  name "JetBrains WebStorm #{version.before_comma}"
  desc "JavaScript IDE"
  homepage "https://www.jetbrains.com/webstorm/"

  app "WebStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webstorm/WebStorm-2023.2.8.dmg"
      sha256 "d52806331771ba0dbd4137c676d957bc12f285126e5247b70d616c32c419cbd7"
  else
      url "https://download.jetbrains.com/webstorm/WebStorm-2023.2.8-aarch64.dmg"
      sha256 "46be0e701f4d197fc2f55268d6c761bdac082007bde7c284c9ca1171f6e0eb04"
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