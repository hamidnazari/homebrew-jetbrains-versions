cask "clion@2024.2.1" do
  version "2024.2.1,242.21829.173"

  name "JetBrains CLion #{version.before_comma}"
  desc "C and C++ IDE"
  homepage "https://www.jetbrains.com/clion/"

  app "CLion.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/cpp/CLion-2024.2.1.dmg"
      sha256 "b5eeedf09b62bba538e630e19f93d339639ec2a646da32b027d4bd66b7d54b7d"
  else
      url "https://download.jetbrains.com/cpp/CLion-2024.2.1-aarch64.dmg"
      sha256 "40564665e759ef179dbf542abe8af57bb15f16c8d05d9c18c700ae81755e6516"
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