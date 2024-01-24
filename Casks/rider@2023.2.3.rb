cask "rider@2023.2.3" do
  version "2023.2.3,232.10203.29"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.2.3.dmg"
      sha256 "362fe0a241d082848925e65d8728e9d3e104b950861b0835c5cc6286656f8ff8"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.2.3-aarch64.dmg"
      sha256 "dbc961f62ac93851478baf48c37337debb3d0174e62916ed108f105280089247"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "rider") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/Rider#{version.major_minor}",
    "~/Library/Caches/Rider#{version.major_minor}",
    "~/Library/Logs/Rider#{version.major_minor}",
    "~/Library/Preferences/jetbrains.rider.71e559ef.plist",
    "~/Library/Preferences/Rider#{version.major_minor}",
    "~/Library/Saved Application State/com.jetbrains.rider.savedState",
  ]
end