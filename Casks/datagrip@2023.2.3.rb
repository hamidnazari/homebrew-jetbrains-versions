cask "datagrip@2023.2.3" do
  version "2023.2.3,232.10203.8"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2023.2.3.dmg"
      sha256 "9c8d4a5d179d03e167961f6dd19c869e69eb3cfd07e6d139bb21c95faca4d078"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2023.2.3-aarch64.dmg"
      sha256 "7b42a9bdc64ebd93363b11152457190d1f04c5bf5a8f00bd8fc014e874ab4793"
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