cask "intellij-idea-ce@2023.2.5" do
  version "2023.2.5,232.10227.8"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2023.2.5.dmg"
      sha256 "8c19b92826ffb5fb4c64a565b178f7d0c46a00a42cc522b9c62a9ce96f0c4632"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2023.2.5-aarch64.dmg"
      sha256 "e630499b2fa52ff0011539cd49954018d7f251ba87279c1976186f1211ed7dad"
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