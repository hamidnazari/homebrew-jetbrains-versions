cask "rider@2022.3.3" do
  version "2022.3.3,223.8836.53"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2022.3.3.dmg"
      sha256 "e06189d3170b7005540de82ad4288111007c1231f15598ee9baa392004d31dae"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2022.3.3-aarch64.dmg"
      sha256 "5284412be4fc781047dda6d0af7bf6bebbc051e6c67bd2cf228ffee83d2d4ccb"
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