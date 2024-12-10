cask "intellij-idea@2024.2.2" do
  version "2024.2.2,242.22855.74"

  name "JetBrains IntelliJ IDEA #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIU-2024.2.2.dmg"
      sha256 "f2528d8f6f983cbfe16e51221a71009ac3a46e8971259bfeb67471253c0d93f0"
  else
      url "https://download.jetbrains.com/idea/ideaIU-2024.2.2-aarch64.dmg"
      sha256 "27b777df1b2ba531d68ef30ebaaf11460a8ab055da8afcfb4886fce3d04d0227"
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