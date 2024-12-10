cask "phpstorm@2023.3.8" do
  version "2023.3.8,233.15619.9"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.3.8.dmg"
      sha256 "fc652c16d3c224eee4ddc19b91e090a16b311d2930e2037dd672511e729e9188"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.3.8-aarch64.dmg"
      sha256 "2a92874ea5a968cc74a6c48fc9fb148884c4ba04e30458c3f3d2a50fb18f6d89"
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