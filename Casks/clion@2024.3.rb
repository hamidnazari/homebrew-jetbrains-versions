cask "clion@2024.3" do
  version "2024.3,243.21565.238"

  name "JetBrains CLion #{version.before_comma}"
  desc "C and C++ IDE"
  homepage "https://www.jetbrains.com/clion/"

  app "CLion.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/cpp/CLion-2024.3.dmg"
      sha256 "e3d82ad3303cb4f373efce378f7f289afd3b35d3315d03ac53dc27302c87aa6f"
  else
      url "https://download.jetbrains.com/cpp/CLion-2024.3-aarch64.dmg"
      sha256 "2f4ad6ea4ffb0862f85780cd960b46925ea6c9e5f97e9fa290f3007652103825"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "clion") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/CLion#{version.major_minor}",
    "~/Library/Caches/JetBrains/CLion#{version.major_minor}",
    "~/Library/Logs/JetBrains/CLion#{version.major_minor}",
    "~/Library/Preferences/CLion#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.CLion.plist",
    "~/Library/Preferences/jetbrains.clion.*.plist",
    "~/Library/Saved Application State/com.jetbrains.CLion.savedState",
  ]
end