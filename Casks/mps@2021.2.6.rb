cask "mps@2021.2.6" do
  version "2021.2.6,212.5284.1433"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.2/MPS-2021.2.6-macos.dmg"
      sha256 "f3d08c6306a1d806308f8949b126befa75cbe93d86cc907f466d72b2b994c8d0"
  else
      url "https://download.jetbrains.com/mps/2021.2/MPS-2021.2.6-macos-aarch64.dmg"
      sha256 "9f9a8b3f640a8bff2efb1bd8727534bc2d58351977c3fa6363ec8f30f8d33fea"
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