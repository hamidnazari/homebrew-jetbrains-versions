cask "rider@2023.3.6" do
  version "2023.3.6,233.15026.35"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.3.6.dmg"
      sha256 "1fc1a22730f023f5c03733aa9c19c10cc292d056aec9431988cd8f71fda1909a"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.3.6-aarch64.dmg"
      sha256 "d61975a73cfe4b20cfcd3b5e43ee3deee34c723578fb3215ba67fb2c7ab327a1"
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