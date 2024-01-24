cask "mps@2021.3.5" do
  version "2021.3.5,213.7172.1189"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.5-macos.dmg"
      sha256 "79b1e587589f0144c6a7e479c6c40c8dbfe6d364ef7c8d3b9a8c9403243c376f"
  else
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.5-macos-aarch64.dmg"
      sha256 "89e50de2d912b03fb6d49581acdf12fa8699447e2dd1c81cfc0897a1edbe56b5"
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