cask "rider@2024.2.7" do
  version "2024.2.7,242.23726.100"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2024.2.7.dmg"
      sha256 "5087643d82f31dbd180bbd8a697915d24b15113fc641f885ae858838ee3b2a3a"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2024.2.7-aarch64.dmg"
      sha256 "119029585ebc8131330a74345f36e87e6455e4d1d902b11bd0f688d4c99d8514"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "rider") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/Rider#{version.major_minor}",
    "~/Library/Caches/Rider#{version.major_minor}",
    "~/Library/Logs/Rider#{version.major_minor}",
    "~/Library/Preferences/jetbrains.rider.71e559ef.plist",
    "~/Library/Preferences/Rider#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.rider.savedState",
  ]
end