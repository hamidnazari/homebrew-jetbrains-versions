cask "phpstorm@2021.2.4" do
  version "2021.2.4,212.5712.51"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2021.2.4.dmg"
      sha256 "71b66b42bd04435e490a7b4b8e2687c3f4280e934907bb40614c81411491b48f"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2021.2.4-aarch64.dmg"
      sha256 "3f0dff87afd2dcb907f925f799d2b463737c1968f6f342eab7734e6fd6d28bb6"
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