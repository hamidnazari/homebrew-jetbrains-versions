cask "appcode@2021.2.5" do
  version "2021.2.5,212.5712.50"

  name "JetBrains AppCode #{version.before_comma}"
  desc "iOS and MacOS Development IDE"
  homepage "https://www.jetbrains.com/objc/"

  app "AppCode.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/objc/AppCode-2021.2.5.dmg"
      sha256 "89c135842d72c3590b79be96134d38cf10c11f1a11534f58efea739cfa873f41"
  else
      url "https://download.jetbrains.com/objc/AppCode-2021.2.5-aarch64.dmg"
      sha256 "b2fe2b6bc44646e716d8094651b96ac542c695b08223613a5bba20e7a00fceba"
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