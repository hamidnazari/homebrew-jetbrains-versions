cask "rider@2023.3.3" do
  version "2023.3.3,233.14015.60"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.3.3.dmg"
      sha256 "a90346a30523eaa2e3abf57abd3949f46e0c6e6d2ea0c62c36d40b07061626cb"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.3.3-aarch64.dmg"
      sha256 "2d6d425610a8d14616cf9a18a0048d678164fcc45f4f5a8ee3fff695012a0c43"
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