cask "mps@2023.2.2" do
  version "2023.2.2,232.10335.1039"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2023.2/MPS-2023.2.2-macos.dmg"
      sha256 "7e9cab1681ae815a333d817090d9171af91e988c2f75f9f88960b6eb43a88bef"
  else
      url "https://download.jetbrains.com/mps/2023.2/MPS-2023.2.2-macos-aarch64.dmg"
      sha256 "5320d0eedb8c1c390521444baaf2bf47b5053c00f09e1384396c047ad0646821"
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