cask "datagrip@2022.1.5" do
  version "2022.1.5,221.5787.39"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2022.1.5.dmg"
      sha256 "ac96ab12d7b4593df21cd466b3cea26bcce0db2c2eb92b5d31456887f500032b"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2022.1.5-aarch64.dmg"
      sha256 "31df43a4f1adab562730adade212916091fc7f7090121001840c1453d2037694"
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