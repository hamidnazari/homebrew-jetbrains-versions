cask "intellij-idea-ce@2024.1.7" do
  version "2024.1.7,241.19416.15"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2024.1.7.dmg"
      sha256 "daad4eee3aacdb84fbd50916dd3ebd5670e6d9e79415360542b00a1836f1271e"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2024.1.7-aarch64.dmg"
      sha256 "b674242c7a46668663f44749df764af551754524ef1658d3e1d8515e17b11811"
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