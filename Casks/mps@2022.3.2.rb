cask "mps@2022.3.2" do
  version "2022.3.2,223.8836.1550"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3.2-macos.dmg"
      sha256 "4e1f2d26ce716559b7a8f96d33dcbb678732a8c3c3210500cd83eaa53fd03dd3"
  else
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3.2-macos-aarch64.dmg"
      sha256 "ca30f94247eec12470055a789228bd594393a9c944a9dffc18db291ee9e074cb"
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