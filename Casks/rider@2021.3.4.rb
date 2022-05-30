cask "rider@2021.3.4" do
  version "2021.3.4,213.7172.34"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2021.3.4.dmg"
      sha256 "4d776c017f7ed614066cf72f00b51fd4a5baf19842affaa5abc4f25fc8bb6eed"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2021.3.4-aarch64.dmg"
      sha256 "c9e60543d48623666373ebfb0c5b8d0cb7ff51b94f27be83080e7361199fe7ab"
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