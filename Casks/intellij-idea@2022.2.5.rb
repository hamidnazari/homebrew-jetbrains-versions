cask "intellij-idea@2022.2.5" do
  version "2022.2.5,222.4554.10"

  name "JetBrains IntelliJ IDEA #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIU-2022.2.5.dmg"
      sha256 "ae3445f38f53718a249018b52dd73a782f095fa5c76c8a9507146a5ed5cba875"
  else
      url "https://download.jetbrains.com/idea/ideaIU-2022.2.5-aarch64.dmg"
      sha256 "223dbd245f053fe1aaf8cceb4a0483bf40a1223b65e33a77e3929657bab35abd"
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