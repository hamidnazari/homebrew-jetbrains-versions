cask "intellij-idea-ce@2021.1.3" do
  version "2021.1.3,211.7628.21"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2021.1.3.dmg"
      sha256 "e23c293f16fb7802f4b6fa3e0537770d28f43f9fdac33809d46ff7ebb5cce1b2"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2021.1.3-aarch64.dmg"
      sha256 "3b2b74168edaab94785d6998e85ee20eb9bcc3f0c193a47573a447729283af38"
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