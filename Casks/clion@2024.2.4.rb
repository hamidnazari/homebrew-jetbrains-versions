cask "clion@2024.2.4" do
  version "2024.2.4,242.24807.15"

  name "JetBrains CLion #{version.before_comma}"
  desc "C and C++ IDE"
  homepage "https://www.jetbrains.com/clion/"

  app "CLion.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/cpp/CLion-2024.2.4.dmg"
      sha256 "5a0c2d77293e382333ded651027c07bf8bfcee2cab733836de3f42ce140445c4"
  else
      url "https://download.jetbrains.com/cpp/CLion-2024.2.4-aarch64.dmg"
      sha256 "0f876cfe042a7c3a87ffe7d467f2659199315fd12588d3d103a726dc764542ed"
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