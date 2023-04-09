cask "rider@2022.2.4" do
  version "2022.2.4,222.4459.9"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2022.2.4.dmg"
      sha256 "147b10fdcfc72f079c54089e07d3850f4b8e5fc25b9e7a67ee167fded89e2149"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2022.2.4-aarch64.dmg"
      sha256 "815e1b77c1280ab21a1a461e81867aa18e0202c13be524d01cf61aa972218c43"
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