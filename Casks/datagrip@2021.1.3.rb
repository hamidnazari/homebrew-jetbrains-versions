cask "datagrip@2021.1.3" do
  version "2021.1.3,211.7442.53"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2021.1.3.dmg"
      sha256 "f640ca34a6845fd4f02480d6fe6555672d6eeb4034f4c0a73b5c1808d2cd0688"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2021.1.3-aarch64.dmg"
      sha256 "dcfda4f2022e510df656d4e1e4eade68dbb28fdbbbcf0d21951efc03fc8e9f2b"
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