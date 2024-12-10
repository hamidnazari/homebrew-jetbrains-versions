cask "goland@2024.2.1" do
  version "2024.2.1,242.21829.165"

  name "JetBrains GoLand #{version.before_comma}"
  desc "Go IDE"
  homepage "https://www.jetbrains.com/go/"

  app "GoLand.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/go/goland-2024.2.1.dmg"
      sha256 "104bfe6afa1cd1262d3f5453726d9c7a83f297a15a47d55d8249b27f4c68b456"
  else
      url "https://download.jetbrains.com/go/goland-2024.2.1-aarch64.dmg"
      sha256 "37c25c788ea559dd1b7b68f6b881c8de2c1a6e4facf77de2e559eb3224a53a2c"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "goland") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/GoLand",
    "~/Library/Application Support/JetBrains/GoLand#{version.major_minor}",
    "~/Library/Caches/JetBrains/GoLand#{version.major_minor}",
    "~/Library/Logs/JetBrains/GoLand#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.goland.plist",
    "~/Library/Preferences/GoLand#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.goland.SavedState",
  ]
end