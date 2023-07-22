cask "appcode@2023.1.4" do
  version "2023.1.4,231.9225.18"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2023.1.4.dmg"
      sha256 "5b7b21cd4c8e3cc2e673013d75b1d057b66991208b49b32f3a52537193414de6"
  else
      url "https://download.jetbrains.com/objc/AppCode-2023.1.4-aarch64.dmg"
      sha256 "c1adba54acc2bad5879096d7fc1a92c31df0e085113a1ddc159da88b227f2b9e"
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