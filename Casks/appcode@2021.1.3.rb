cask "appcode@2021.1.3" do
  version "2021.1.3,211.7628.36"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2021.1.3.dmg"
      sha256 "b7c2e5256128b14911b0472f74d7270d9e1bc7ff5697d28cdf8333ec7c7810d6"
  else
      url "https://download.jetbrains.com/objc/AppCode-2021.1.3-aarch64.dmg"
      sha256 "dacb08e0e4fe22545a4d2e8a52b81bfc9cf28bc25af044a61af6a37684abdf8d"
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