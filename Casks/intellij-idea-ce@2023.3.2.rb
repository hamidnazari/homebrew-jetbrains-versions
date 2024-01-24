cask "intellij-idea-ce@2023.3.2" do
  version "2023.3.2,233.13135.103"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2023.3.2.dmg"
      sha256 "4aafb17af1cf299599a9c6a9ad56dcb5f93c2181ba2bc5c5222cd61cfd0b413a"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2023.3.2-aarch64.dmg"
      sha256 "dbe04f98d8b576ffb1f3f190c51a4065e111fd4f2d113fab9c8383f8ead46176"
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