cask "datagrip@2023.3.4" do
  version "2023.3.4,233.14015.137"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2023.3.4.dmg"
      sha256 "730a1f17882432ad01b936a6d621c4c3acbfce0bd693b3ca4ee488182ab04d99"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2023.3.4-aarch64.dmg"
      sha256 "2dc136c60d6c4c2cc13dc2d426c564dd34e56625dfbfb84d1900b175ea5d6273"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "datagrip") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/DataGrip*",
    "~/Library/Caches/JetBrains/DataGrip*",
    "~/Library/Logs/JetBrains/DataGrip*",
    "~/Library/Saved Application State/com.jetbrains.datagrip.savedState",
  ]
end