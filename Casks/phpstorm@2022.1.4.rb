cask "phpstorm@2022.1.4" do
  version "2022.1.4,221.6008.16"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2022.1.4.dmg"
      sha256 "dff27c7e924c4d985bd08c64ae220ca209a7954e10aa26c67bbce4c424053427"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2022.1.4-aarch64.dmg"
      sha256 "ff0c226651dfdc02536c5d49e51ba759596e6567f58b345001fd6476da4656bf"
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