cask "datagrip@2024.2.2" do
  version "2024.2.2,242.21829.162"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2024.2.2.dmg"
      sha256 "bc6247f976dfc216c86f9ff05a8401172af213230464bcff247ee432ce3140f4"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2024.2.2-aarch64.dmg"
      sha256 "9f92c4ba7d60a9df1e4450278125733ba1fed499d4a27bbd753d8c0d33a57dcb"
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