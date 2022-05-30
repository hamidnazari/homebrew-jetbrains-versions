cask "phpstorm@2021.3.3" do
  version "2021.3.3,213.7172.28"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2021.3.3.dmg"
      sha256 "5a9c72a9af0ab725ef95d4bb9f760d4766ea56c1af0d48f798befd5a26094cc5"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2021.3.3-aarch64.dmg"
      sha256 "382cdc90497b461719b99e4df1ac2b88b301fa165cd66decc5696aaab65f9909"
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