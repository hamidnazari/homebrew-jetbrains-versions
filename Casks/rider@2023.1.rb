cask "rider@2023.1" do
  version "2023.1,231.8109.212"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.1.dmg"
      sha256 "fe6ee0086b3e59eecc7e2816e8f803a702a6b7ea382cb0a2168d08d19dd656d7"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.1-aarch64.dmg"
      sha256 "dbd708379f2a489add7e87a321297841baf8bfcf83ce2f5549a1ff9f5037cf46"
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