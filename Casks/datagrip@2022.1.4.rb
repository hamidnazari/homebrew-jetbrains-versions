cask "datagrip@2022.1.4" do
  version "2022.1.4,221.5591.57"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2022.1.4.dmg"
      sha256 "4ebeeee933370c898c6a4a099df6285558f46866b0a7ba450375036366ab559e"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2022.1.4-aarch64.dmg"
      sha256 "b027c71e2bb5b05ea539cb5c5eda866ef859f7f3ad61f72584db7a314f75981e"
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