cask "phpstorm@2023.2.4" do
  version "2023.2.4,232.10227.13"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.2.4.dmg"
      sha256 "cba432cf0a29e55a92fb89daa58f27f590c79e21ad3d46cd37b1da2c9a10ade7"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.2.4-aarch64.dmg"
      sha256 "7ba3c7573b478ae004e296af4ddf8fbdf05b8453c41a06675b1a2350990f09b0"
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