cask "mps@2022.3.3" do
  version "2022.3.3,223.8836.1611"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3.3-macos.dmg"
      sha256 "8a59c4024d5cb6469703b138c169c726ad9ed5ca390160620287b5debf96da3f"
  else
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3.3-macos-aarch64.dmg"
      sha256 "901ebad11a728f0b449233494d530a1c1a4c3e51d90b1328cbb58c28a76e50aa"
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