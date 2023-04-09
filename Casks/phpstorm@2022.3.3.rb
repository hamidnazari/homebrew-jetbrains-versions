cask "phpstorm@2022.3.3" do
  version "2022.3.3,223.8836.42"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2022.3.3.dmg"
      sha256 "79f5857f95452a6f66ba4ddbfd4445290449f21b90e6fd37e6118ac17cc052ed"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2022.3.3-aarch64.dmg"
      sha256 "23ba3a7ff84216b945327241be759429040bd09bc4269a01b77a2e3745c66132"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "pstorm") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/PhpStorm#{version.major_minor}",
    "~/Library/Caches/PhpStorm#{version.major_minor}",
    "~/Library/Logs/PhpStorm#{version.major_minor}",
    "~/Library/Preferences/jetbrains.phpstorm.*.plist",
    "~/Library/Preferences/PhpStorm#{version.major_minor}",
  ]
end