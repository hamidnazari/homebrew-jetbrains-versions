cask "phpstorm@2024.2.1" do
  version "2024.2.1,242.21829.154"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2024.2.1.dmg"
      sha256 "19c03065045eb8acfd1a2aad24de23a057f630e75761edf71927a31c0c942873"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2024.2.1-aarch64.dmg"
      sha256 "84ce46f11f5748dac2fe2a209d3b97984546e38cc39799838eeab681301306cc"
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