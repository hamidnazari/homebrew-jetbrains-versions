cask "clion@2023.3.6" do
  version "2023.3.6,233.15619.8"

  name "JetBrains CLion #{version.before_comma}"
  desc "C and C++ IDE"
  homepage "https://www.jetbrains.com/clion/"

  app "CLion.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/cpp/CLion-2023.3.6.dmg"
      sha256 "c41172e4bed6908ddc8c23f7a078f9ad3fa974b7252fdd8b4f0797a9213e0608"
  else
      url "https://download.jetbrains.com/cpp/CLion-2023.3.6-aarch64.dmg"
      sha256 "8429c9533ade5321ea8058daf689699ab019567f022340502f5c77d001093dbe"
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