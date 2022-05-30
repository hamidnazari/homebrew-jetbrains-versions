cask "appcode@2021.3.3" do
  version "2021.3.3,213.7172.21"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2021.3.3.dmg"
      sha256 "51fde6d9909bdc1a2407f27f333e6f1751cad203787dd1041699836d5ee85e67"
  else
      url "https://download.jetbrains.com/objc/AppCode-2021.3.3-aarch64.dmg"
      sha256 "9cc9c2b3e62c4ccf484d82c25641da60a56a4a7b52285ee7a49528a01cb1cab8"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "appcode") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/AppCode#{version.major_minor}",
    "~/Library/Caches/AppCode#{version.major_minor}",
    "~/Library/Logs/AppCode#{version.major_minor}",
    "~/Library/Preferences/AppCode#{version.major_minor}",
  ]
end