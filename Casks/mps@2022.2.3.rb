cask "mps@2022.2.3" do
  version "2022.2.3,222.4554.1662"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.3-macos.dmg"
      sha256 "6e39c8231fedaab80adc62f6ec8fcba2b3a7516c564c69246ad248a54f0ce797"
  else
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.3-macos-aarch64.dmg"
      sha256 "50821eb8da7065a5f6a7905314ee616ea0b1512038b5e307c7ed1e7d252d6a69"
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