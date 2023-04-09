cask "mps@2021.3.2" do
  version "2021.3.2,213.7172.1022"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.2-macos.dmg"
      sha256 "599b2dc30b0de3e00c17b0e111e7af63a5648a72aa22aec4b4e47d4e0dc1aaf4"
  else
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.2-macos-aarch64.dmg"
      sha256 "00b8655186d5a5f56b98788e48f918c7713c855260eb17b4939e691f0aff9c58"
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