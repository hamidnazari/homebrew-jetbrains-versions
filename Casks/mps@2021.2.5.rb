cask "mps@2021.2.5" do
  version "2021.2.5,212.5284.1355"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.2/MPS-2021.2.5-macos.dmg"
      sha256 "96b6077db41307fadaf8cb0a6d4e1cabaf157b6ca6cc4fa5a7a89cee3704262e"
  else
      url "https://download.jetbrains.com/mps/2021.2/MPS-2021.2.5-macos-aarch64.dmg"
      sha256 "31861c7e244c1ebc3c998f345e6dc6ce28d249235cefa9e4ae7db91d229e57d0"
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