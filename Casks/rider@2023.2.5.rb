cask "rider@2023.2.5" do
  version "2023.2.5,232.10300.55"

  name "JetBrains Rider #{version.before_comma}"
  desc ".NET IDE"
  homepage "https://www.jetbrains.com/rider/"

  app "Rider.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.2.5.dmg"
      sha256 "0f88d8bcb5ca69f4f796bdf2f10f8349e9e9a4198946d421167d61229192c180"
  else
      url "https://download.jetbrains.com/rider/JetBrains.Rider-2023.2.5-aarch64.dmg"
      sha256 "33ae80e9aa8bde692b289ea3d8a07a0e842fdbbeb84c9fa7f2568f00615fe0aa"
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