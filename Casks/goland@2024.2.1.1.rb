cask "goland@2024.2.1.1" do
  version "2024.2.1.1,242.21829.220"

  name "JetBrains GoLand #{version.before_comma}"
  desc "Go IDE"
  homepage "https://www.jetbrains.com/go/"

  app "GoLand.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/go/goland-2024.2.1.1.dmg"
      sha256 "44c84b628665b4778ae4981419b796f0eed3942d43a99b2f7692706452aef493"
  else
      url "https://download.jetbrains.com/go/goland-2024.2.1.1-aarch64.dmg"
      sha256 "0ba62dbed71550a9c1e1535f6a1d6dbfe826d0bf1f7da84e40d9dee9b8e358b8"
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