cask "datagrip@2024.2.1" do
  version "2024.2.1,242.20224.385"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2024.2.1.dmg"
      sha256 "2053c1305fbabee20cf8a26aee2b939ff8965b2f7402639c09652798ebd37da6"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2024.2.1-aarch64.dmg"
      sha256 "6b8505ef67de19f312ce78bdbc067093aa95f78407a863b6baa16c7df98a6a98"
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