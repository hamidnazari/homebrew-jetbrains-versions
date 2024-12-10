cask "clion@2024.1.6" do
  version "2024.1.6,241.19416.21"

  name "JetBrains CLion #{version.before_comma}"
  desc "C and C++ IDE"
  homepage "https://www.jetbrains.com/clion/"

  app "CLion.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/cpp/CLion-2024.1.6.dmg"
      sha256 "7620267b3cd9a23512614da78d4aced475ed4885ccf229bd2ee2d99f7051631b"
  else
      url "https://download.jetbrains.com/cpp/CLion-2024.1.6-aarch64.dmg"
      sha256 "5dd7db0033678f3185fac78e2d10702353fd301f636029b1151e108ee14f4415"
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