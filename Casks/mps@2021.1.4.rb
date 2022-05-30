cask "mps@2021.1.4" do
  version "2021.1.4,211.7628.1509"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.1/MPS-2021.1.4-macos.dmg"
      sha256 "e54041cddce2d80e0426e8bb35327133c2d1db3748f0702878a55ebf684ea64b"
  else
      url "https://download.jetbrains.com/mps/2021.1/MPS-2021.1.4-macos-aarch64.dmg"
      sha256 "5ffbfe638e6bcc9dcbf4450471d690c5faa3c231e11eaae9bbf350870042ab5f"
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