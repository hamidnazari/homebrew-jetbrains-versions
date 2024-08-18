cask "rider@2024.1.6" do
  version "2024.1.6,241.19072.26"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2024.1.6.dmg"
      sha256 "a6d28629ac4393c3d6636a09958de27a095a718d8531e7a7a511d50bf6919b61"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2024.1.6-aarch64.dmg"
      sha256 "22d89aaa841f2ff4b5930a06d44c4efc0dbd9aaee7912c2d12dd103083ecd8c8"
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