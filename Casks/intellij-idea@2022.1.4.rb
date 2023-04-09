cask "intellij-idea@2022.1.4" do
  version "2022.1.4,221.6008.13"

  name "JetBrains IntelliJ IDEA #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIU-2022.1.4.dmg"
      sha256 "c30c823d24a79eefc4a0f8e9c497c5e4e984cc44e9bcd011dae2a593926b46ea"
  else
      url "https://download.jetbrains.com/idea/ideaIU-2022.1.4-aarch64.dmg"
      sha256 "d324ee0ea7f72855826921eaa689b9a53b6038d752b6e5f7f895f3bf0d727d3b"
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