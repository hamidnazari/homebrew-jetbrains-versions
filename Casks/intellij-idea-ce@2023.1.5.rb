cask "intellij-idea-ce@2023.1.5" do
  version "2023.1.5,231.9392.1"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2023.1.5.dmg"
      sha256 "bb497c5924a8eb135f5e0f394c9913b8d5f138560a1163a0090eb2fe34ea8c1e"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2023.1.5-aarch64.dmg"
      sha256 "d5e960f35351ba22a069181a853fe950fd523b5c2dbbf7535cf7341e51508325"
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