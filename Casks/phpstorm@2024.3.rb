cask "phpstorm@2024.3" do
  version "2024.3,243.21565.202"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2024.3.dmg"
      sha256 "1383a1fecafa9b84338fef846f434b6deac2849afb4876de544550b86c0c3c01"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2024.3-aarch64.dmg"
      sha256 "95ed8e4ad4f94a159beec0306135b6bb85e0045d6afe3e4c2364d90901ae39b5"
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