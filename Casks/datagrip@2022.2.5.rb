cask "datagrip@2022.2.5" do
  version "2022.2.5,222.4345.5"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2022.2.5.dmg"
      sha256 "cdf0302b0ab65d3dfce4e48004ef45873c9912c844d2e3c82bfe19de2b11cfda"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2022.2.5-aarch64.dmg"
      sha256 "8ff78e440e4753adc8dbd4ee408fde114f7d9c65ee780f012b917498b63993ee"
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