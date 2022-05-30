cask "intellij-idea-ce@2020.3.4" do
  version "2020.3.4,203.8084.24"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2020.3.4.dmg"
      sha256 "eda5f6052dcedf928dd3337847071e41ad0c2c71ba0b29fa2d9a937f990c4e20"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2020.3.4-aarch64.dmg"
      sha256 "9ad2333c6ae3f051ce7ca59140178107c3de8f0b929a6b123d97e89fb12fdd7e"
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