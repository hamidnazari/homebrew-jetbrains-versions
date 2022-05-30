cask "intellij-idea-ce@2021.2.4" do
  version "2021.2.4,212.5712.43"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2021.2.4.dmg"
      sha256 "6aecf3002f9860b09b098c4fc6cb16ba1d4a4f0c5410298126c8351f03935ed8"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2021.2.4-aarch64.dmg"
      sha256 "631357e32f2d5d1f0027a67622d8d2623d69a5f10cf78bd45f234f1b32fdb526"
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