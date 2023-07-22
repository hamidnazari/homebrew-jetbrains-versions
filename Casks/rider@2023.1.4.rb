cask "rider@2023.1.4" do
  version "2023.1.4,231.9225.23"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.1.4.dmg"
      sha256 "5f1fc9acebd587902908e310a97ff4e0fb12e6d840584618ffff6102d756d703"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.1.4-aarch64.dmg"
      sha256 "3995b3566fb64938931d6308891cc63d1a7743076d27cab4ebee1ed028d8f9a5"
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