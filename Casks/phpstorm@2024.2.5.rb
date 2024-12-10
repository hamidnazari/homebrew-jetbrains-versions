cask "phpstorm@2024.2.5" do
  version "2024.2.5,242.24807.17"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2024.2.5.dmg"
      sha256 "4b8501689ea1f6f398b76e12cd11d8f8661a13d41a5a12a4968c949a12f6bb56"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2024.2.5-aarch64.dmg"
      sha256 "515b452725e8650820c2a429bdd2e12d83751af9ca329c414fea3b05a81dd0e6"
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