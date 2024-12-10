cask "datagrip@2024.3.2" do
  version "2024.3.2,243.22562.115"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2024.3.2.dmg"
      sha256 "2098f0056478c8ce86294bef246ba204fd6ea0332c0ca4fd96bd09b2f1bdf1a6"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2024.3.2-aarch64.dmg"
      sha256 "aa7776cf0a7c39e1968b28ea3977f381fa63c83854b9e647ac0ec93eb9c10e4b"
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