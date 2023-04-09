cask "phpstorm@2023.1" do
  version "2023.1,231.8109.199"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.1.dmg"
      sha256 "825c4626f4f4359cb47f2e6f74d8fe23df0fb991f2ac4cbb86b99a6c8dbee5f6"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.1-aarch64.dmg"
      sha256 "030d0b8f7ef486fa5dc757fcb2c5c5678d9f9dcc27769f79996c631c299657e7"
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