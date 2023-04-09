cask "phpstorm@2022.2.5" do
  version "2022.2.5,222.4554.13"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2022.2.5.dmg"
      sha256 "72396ad574f7f6aef37ae70434d7a9d93cf406f56c98da5380b7ddeda97f0a92"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2022.2.5-aarch64.dmg"
      sha256 "adba57f2a5c727d7dd81752f3e1aaac043becb7f29bfd09368e805c29db172fa"
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