cask "intellij-idea-ce@2022.1.4" do
  version "2022.1.4,221.6008.13"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2022.1.4.dmg"
      sha256 "90b08b3a79b64f1d4c9a08c05b9818d31aa64dbdefadc8bc5490fc4443b05505"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2022.1.4-aarch64.dmg"
      sha256 "1a82ab3573025775e06092d24c3b86eb4a12c3151740ec8de73c1974a78f0615"
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