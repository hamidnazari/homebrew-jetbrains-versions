cask "webstorm@2024.3.1" do
  version "2024.3.1,243.22562.112"

  name "JetBrains WebStorm #{version.before_comma}"
  desc "JavaScript IDE"
  homepage "https://www.jetbrains.com/webstorm/"

  app "WebStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webstorm/WebStorm-2024.3.1.dmg"
      sha256 "92ef1b0682de2c0aca51bd613fe45dbf4fa6178c33d63f30eda33b68d6a5be93"
  else
      url "https://download.jetbrains.com/webstorm/WebStorm-2024.3.1-aarch64.dmg"
      sha256 "1e17aea814f6168d0c0a7c519dada50486c0c09cb8f9b5c58fe3bf8f051a8a14"
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