cask "rider@2023.1.7" do
  version "2023.1.7,231.9414.21"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.1.7.dmg"
      sha256 "05ca212ff31099ca8c7584d4c5c8e8d4abe5f3fd72c129c7273bc0ce20e68da9"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.1.7-aarch64.dmg"
      sha256 "a71e4e142d25ef5b922643ec9e354f98516fc87ce66de7e4f6c52e52b1f3fe37"
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