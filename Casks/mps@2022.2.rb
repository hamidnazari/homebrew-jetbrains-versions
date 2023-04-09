cask "mps@2022.2" do
  version "2022.2,222.3345.1295"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2-macos.dmg"
      sha256 "4e36c60d281596c220287ab2191165be37ef01c3c54ab5f5e4e535c8b81bc754"
  else
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2-macos-aarch64.dmg"
      sha256 "bdc83d9c7a3430cc2b0b0361a9e4eab82e951bfe87f0e4754106d09850947077"
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