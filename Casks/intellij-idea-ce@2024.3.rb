cask "intellij-idea-ce@2024.3" do
  version "2024.3,243.21565.193"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2024.3.dmg"
      sha256 "9162a57c3f39c2f54b9ab86f41ae25de839e749c1708e674deef59c40c4f577f"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2024.3-aarch64.dmg"
      sha256 "568e0a3a1d623627411abed770ce20c2a9906331335e4576c72f019a1e992267"
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