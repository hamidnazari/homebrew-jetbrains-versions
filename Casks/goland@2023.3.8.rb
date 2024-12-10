cask "goland@2023.3.8" do
  version "2023.3.8,233.15619.13"

  name "JetBrains GoLand #{version.before_comma}"
  desc "Go IDE"
  homepage "https://www.jetbrains.com/go/"

  app "GoLand.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/go/goland-2023.3.8.dmg"
      sha256 "477753cbaafb6a42b382be34a121a0b4ea287e4d4c294627dffa165a6ac9091a"
  else
      url "https://download.jetbrains.com/go/goland-2023.3.8-aarch64.dmg"
      sha256 "2493bdacaa26f0fb65678bee2f9248539a31001f5946c25585f1abdbc6e13370"
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