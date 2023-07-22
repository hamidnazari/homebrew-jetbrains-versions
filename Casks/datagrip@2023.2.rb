cask "datagrip@2023.2" do
  version "2023.2,232.8660.111"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2023.2.dmg"
      sha256 "0457a7503d4a1f0824777f5e27416831070b109be93c9c7bc465065c76631009"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2023.2-aarch64.dmg"
      sha256 "51a9ba6f4448ffc10474522df6b5264972286599ee8165f9b961cd99c1c08bdd"
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