cask "phpstorm@2021.1.4" do
  version "2021.1.4,211.7628.25"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2021.1.4.dmg"
      sha256 "3d19209814b08db70c5add5b14501ffd4ab6ff9c6696e672e757be6b7ea08329"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2021.1.4-aarch64.dmg"
      sha256 "c9df401adaa3991cef6297f979e700ffddfdaa231943b84f7e1deef44bd2c9d3"
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