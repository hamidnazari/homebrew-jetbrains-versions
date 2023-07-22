cask "phpstorm@2023.1.4" do
  version "2023.1.4,231.9225.18"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.1.4.dmg"
      sha256 "4d3d9005772d2136e44f7774377fae053b690501800ea5e650d0f35882690fdd"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.1.4-aarch64.dmg"
      sha256 "3285135fc4c529640ecfc5b451fa9b51d9df2a323915509cc6cbb3f25717c9e2"
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