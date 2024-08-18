cask "phpstorm@2023.3.7" do
  version "2023.3.7,233.15325.16"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.3.7.dmg"
      sha256 "efead346de4fe4991e06165b121bddcc6e1d48970bc40b4be3a7983956a4dd1e"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.3.7-aarch64.dmg"
      sha256 "d95fd0351b6c535ea4c2c13150408329c8610c2a1e587f135b640d94fd1d8ff2"
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