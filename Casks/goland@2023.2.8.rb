cask "goland@2023.2.8" do
  version "2023.2.8,232.10335.16"

  name "JetBrains GoLand #{version.before_comma}"
  desc "Go IDE"
  homepage "https://www.jetbrains.com/go/"

  app "GoLand.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/go/goland-2023.2.8.dmg"
      sha256 "65eb8840105c99faaf0bc7f3859e8a197714d022d30cb8922ff67470099b07b7"
  else
      url "https://download.jetbrains.com/go/goland-2023.2.8-aarch64.dmg"
      sha256 "2605f37cc5a8900202e04c0dbd24b5bd92a0312d9e753e6654c6d4e49f43f664"
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