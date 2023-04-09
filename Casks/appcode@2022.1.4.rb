cask "appcode@2022.1.4" do
  version "2022.1.4,221.6008.18"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2022.1.4.dmg"
      sha256 "cfe9e6861a6f1ee74e0628733e171534e87ead124af45c0fe264fa2b93f4a476"
  else
      url "https://download.jetbrains.com/objc/AppCode-2022.1.4-aarch64.dmg"
      sha256 "f379ba2ba5bdbd11a73615ba2268311f73c830b65531c282cce7179080bd80d1"
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