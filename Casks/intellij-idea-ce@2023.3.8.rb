cask "intellij-idea-ce@2023.3.8" do
  version "2023.3.8,233.15619.7"

  name "JetBrains IntelliJ IDEA Community Edition #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA CE.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIC-2023.3.8.dmg"
      sha256 "7fdc45d17f0bea75ca8ebf9e68fe775c6f5b2d4191ae40795b590cff63330587"
  else
      url "https://download.jetbrains.com/idea/ideaIC-2023.3.8-aarch64.dmg"
      sha256 "8e5bb80ca2f2efac991c0e0f83a4cab24c17f49d3aeb91616e8292533dcfbac2"
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