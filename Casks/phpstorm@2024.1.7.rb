cask "phpstorm@2024.1.7" do
  version "2024.1.7,241.19416.23"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2024.1.7.dmg"
      sha256 "31a35cf59514ba74f5926d7648d327f77127047325cf9da209ddc328605cd445"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2024.1.7-aarch64.dmg"
      sha256 "69fd9c7a02e38c31f720ae1833fb2fda44603607b6a1ca474a0d2536fcc5910d"
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