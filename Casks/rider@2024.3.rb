cask "rider@2024.3" do
  version "2024.3,243.21565.191"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2024.3.dmg"
      sha256 "b8552f7e124b3d7678d6b7dfe3b54b13a70f70c4523f19d36f52172dc276ad3c"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2024.3-aarch64.dmg"
      sha256 "2ca76a1d37bd429c8cfd8792512ecd6a9ff385c152e65c68a4620c8a67441e44"
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