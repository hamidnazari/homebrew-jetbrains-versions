cask "mps@2023.3.1" do
  version "2023.3.1,233.13135.1068"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2023.3/MPS-2023.3.1-macos.dmg"
      sha256 "8dfc7754f4fd20d07630ef86b1ff985e96c5e0183b7a4624b7d2de5139a6ac2c"
  else
      url "https://download.jetbrains.com/mps/2023.3/MPS-2023.3.1-macos-aarch64.dmg"
      sha256 "d7512decb18b8df940f7e5d7a8f15c85e3c2ad236202f5d7369cdc24dacf480f"
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