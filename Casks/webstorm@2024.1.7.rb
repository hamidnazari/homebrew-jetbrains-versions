cask "webstorm@2024.1.7" do
  version "2024.1.7,241.19416.2"

  name "JetBrains WebStorm #{version.before_comma}"
  desc "JavaScript IDE"
  homepage "https://www.jetbrains.com/webstorm/"

  app "WebStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webstorm/WebStorm-2024.1.7.dmg"
      sha256 "74a7f1dd7f3d8c28520fc239d6d0f5c78199772dac7e30a6ebceb997ac6af4bb"
  else
      url "https://download.jetbrains.com/webstorm/WebStorm-2024.1.7-aarch64.dmg"
      sha256 "5eb8ffc30941a199e9dab84741149db85107951236bfddb29f7cf9fc1322de66"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "wstorm") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/WebStorm#{version.major_minor}",
    "~/Library/Caches/JetBrains/WebStorm#{version.major_minor}",
    "~/Library/Logs/JetBrains/WebStorm#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.WebStorm.plist",
    "~/Library/Preferences/jetbrains.webstorm.*.plist",
    "~/Library/Preferences/WebStorm#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.WebStorm.savedState",
  ]
end