cask "datagrip@2023.1.2" do
  version "2023.1.2,231.9011.35"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2023.1.2.dmg"
      sha256 "13302c2cda09fdf08025430cfb195d7cbf34ad0f66968091e5227a8ff71a7f79"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2023.1.2-aarch64.dmg"
      sha256 "3af05578dd8c3b01a5b75e34b0944bccd307ce698e80fe238044762785920c90"
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