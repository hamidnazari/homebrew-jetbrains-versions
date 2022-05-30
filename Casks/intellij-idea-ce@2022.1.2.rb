cask "intellij-idea-ce@2022.1.2" do
  version "2022.1.2,221.5787.30"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2022.1.2.dmg"
      sha256 "fcf1bd4677bd43426632212565400238078257af7d6429fa5654ad26728aab45"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2022.1.2-aarch64.dmg"
      sha256 "8d0b844147dc57b13b432af3bd0f9f705f9ab184cb75010ef317656047de7ad0"
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