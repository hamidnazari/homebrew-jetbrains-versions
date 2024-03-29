cask "goland@2022.1.4" do
  version "2022.1.4,221.6008.15"

  name "JetBrains GoLand #{version.before_comma}"
  desc "Go IDE"
  homepage "https://www.jetbrains.com/go/"

  app "GoLand.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/go/goland-2022.1.4.dmg"
      sha256 "7eb050aae9eb92d05c877f2f71710bd57258fc129ec9c83c2b1da9375cf847e5"
  else
      url "https://download.jetbrains.com/go/goland-2022.1.4-aarch64.dmg"
      sha256 "2b497cc725a24bccc4599808e6b7513fc884240ac08b3b749cea472373298c20"
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