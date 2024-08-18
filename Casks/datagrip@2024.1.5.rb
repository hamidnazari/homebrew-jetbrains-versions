cask "datagrip@2024.1.5" do
  version "2024.1.5,241.19072.24"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2024.1.5.dmg"
      sha256 "20a505b581877da78cc431651f47d65f47986d6e7901b1649eabcc688454ca05"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2024.1.5-aarch64.dmg"
      sha256 "f1c49335ecbf2b12839755ac523eb5ec07031cf190917457d22351ea63dddb7b"
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