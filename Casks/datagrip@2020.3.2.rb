cask "datagrip@2020.3.2" do
  version "2020.3.2,203.7148.68"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2020.3.2.dmg"
      sha256 "dbdc49e06cf2d120e55eecaa0cb6d5588a9ca73b0efd4607d6c2ad4fc8a36d0b"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2020.3.2-aarch64.dmg"
      sha256 "95d28b0a0faa9a6e131bfef9bfe321bdf028be7624345e3416c0f26ef7a95f96"
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