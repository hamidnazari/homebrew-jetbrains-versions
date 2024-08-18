cask "phpstorm@2023.2.6" do
  version "2023.2.6,232.10319.9"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.2.6.dmg"
      sha256 "3146e56d24a2866fcab6581ea8747bbd5fbf808fee46ddfc98414d11087dfb89"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.2.6-aarch64.dmg"
      sha256 "e93a22917cb5343a04b97b457385e39b63834405472f601ce36bfd54647fb9e7"
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