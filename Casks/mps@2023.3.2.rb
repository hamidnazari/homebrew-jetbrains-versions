cask "mps@2023.3.2" do
  version "2023.3.2,233.15619.1151"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2023.3/MPS-2023.3.2-macos.dmg"
      sha256 "579d93078a1dde38c41513889a06fb5bbda7d6437da6bfcb8fe907ea45c9fc6d"
  else
      url "https://download.jetbrains.com/mps/2023.3/MPS-2023.3.2-macos-aarch64.dmg"
      sha256 "6bbc0c00b85b6cdeb53cd4c9e4b2d6fa81f9180d30f16b74dd94690095feb327"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "mps") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/MPS#{version.csv.first.major_minor}",
    "~/Library/Caches/MPS#{version.csv.first.major_minor}",
    "~/Library/Logs/MPS#{version.csv.first.major_minor}",
    "~/Library/Preferences/MPS#{version.csv.first.major_minor}",
    "~/MPSSamples.#{version.csv.first.major_minor}",
  ]
end