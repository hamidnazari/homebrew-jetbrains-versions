cask "appcode@2023.1.5" do
  version "2023.1.5,231.9423.10"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2023.1.5.dmg"
      sha256 "5145f184d76cf852f4dbb247f8aa36e7c061a9055bd203d73399b8b00b053673"
  else
      url "https://download.jetbrains.com/objc/AppCode-2023.1.5-aarch64.dmg"
      sha256 "fe1b1e2258cd7ae954bddf96dc661584653b1d36603f39d0a93c6162e7e57702"
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