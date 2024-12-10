cask "intellij-idea-ce@2024.2.2" do
  version "2024.2.2,242.22855.74"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2024.2.2.dmg"
      sha256 "993676b837c7c08069120210d64d1bf32f260b40698014f4a4d1bffa763dd830"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2024.2.2-aarch64.dmg"
      sha256 "cb71c104ac76d0cba1e44cac61f1d463bb9d62fe139477966407e21bc30d8ea0"
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
    "~/Library/Application Support/JetBrains/IdeaIC#{version.major_minor}",
    "~/Library/Caches/JetBrains/IdeaIC#{version.major_minor}",
    "~/Library/Logs/JetBrains/IdeaIC#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.intellij.ce.plist",
    "~/Library/Saved Application State/com.jetbrains.intellij.ce.savedState",
  ]
end