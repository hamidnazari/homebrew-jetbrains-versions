cask "rider@2022.1.2" do
  version "2022.1.2,221.5787.36"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2022.1.2.dmg"
      sha256 "ddcf6544e7302632a117ec00cf2e20688b53a47319114418fa55f7304bf49b82"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2022.1.2-aarch64.dmg"
      sha256 "81ce9020cc2b20f50ce73efe80969b054fce2a62a1736aed877a1141eaf07d4b"
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