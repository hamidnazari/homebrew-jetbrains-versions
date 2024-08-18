cask "phpstorm@2023.1.6" do
  version "2023.1.6,231.9423.7"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.1.6.dmg"
      sha256 "cdb7b736260a4be858ee6fee674d54669f94923dd1f959476a7c65415035e5cf"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.1.6-aarch64.dmg"
      sha256 "c6b18fdd325003dba986c4e4133df167e61452d5d28474f48b7948c96f6b2db3"
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