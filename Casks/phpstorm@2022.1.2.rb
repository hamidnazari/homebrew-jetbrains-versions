cask "phpstorm@2022.1.2" do
  version "2022.1.2,221.5787.33"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2022.1.2.dmg"
      sha256 "29695fccbb2057d0394f30fb334781e1838a0acff86497143498e90ed773b016"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2022.1.2-aarch64.dmg"
      sha256 "4e5e78199ccf9b95f0b45b5c50169062a2b6f14685f4bc53569bab1aa72f442a"
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