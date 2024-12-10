cask "intellij-idea@2023.2.8" do
  version "2023.2.8,232.10335.12"

  name "JetBrains IntelliJ IDEA #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIU-2023.2.8.dmg"
      sha256 "243b0551bcb0ad325a010a4ff8a81c6e4d6d655f7490e269126665f011f6ced9"
  else
      url "https://download.jetbrains.com/idea/ideaIU-2023.2.8-aarch64.dmg"
      sha256 "e8b3a01b1fd9029edc29f07059fc7eec2d92e68328441b3c623e55be08d99063"
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