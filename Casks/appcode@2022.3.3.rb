cask "appcode@2022.3.3" do
  version "2022.3.3,223.8836.52"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2022.3.3.dmg"
      sha256 "cc300aa2d21a82191e9c360bfcf29a1b1b86f51d284c1e9b70e9c50f137b8707"
  else
      url "https://download.jetbrains.com/objc/AppCode-2022.3.3-aarch64.dmg"
      sha256 "3d57c737d8f3b0c4e31e394a3e1230cf6f995e20df95c940c65aef76d9635ad5"
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