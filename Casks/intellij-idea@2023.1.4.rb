cask "intellij-idea@2023.1.4" do
  version "2023.1.4,231.9225.16"

  name "JetBrains IntelliJ IDEA #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIU-2023.1.4.dmg"
      sha256 "d039c8789724962fa264d55d47ac2e5efc2779fd082dcb6615ae15b2ca66ce91"
  else
      url "https://download.jetbrains.com/idea/ideaIU-2023.1.4-aarch64.dmg"
      sha256 "a03b9357a0d54936df1631f75d11d2647bc89ca5c5baaa4af07a58ab729924cc"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "idea") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/IntelliJIdea#{version.major_minor}",
    "~/Library/Caches/JetBrains/IntelliJIdea#{version.major_minor}",
    "~/Library/Logs/JetBrains/IntelliJIdea#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.intellij.plist",
    "~/Library/Preferences/IntelliJIdea#{version.major_minor}",
    "~/Library/Preferences/jetbrains.idea.*.plist",
    "~/Library/Saved Application State/com.jetbrains.intellij.savedState",
  ]
end