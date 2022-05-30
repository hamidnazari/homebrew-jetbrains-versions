cask "datagrip@2021.2.4" do
  version "2021.2.4,212.5457.41"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2021.2.4.dmg"
      sha256 "0062c8ba1ea8cdec91f3ad5d909f79e2275a619cc2e0f246e1bf1b8c34e0b27d"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2021.2.4-aarch64.dmg"
      sha256 "ce8a19860fd71b91bd6e64fcf0e95995f1e0a14aa46e33bfaf6182351f92a933"
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