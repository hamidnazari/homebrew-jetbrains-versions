cask "mps@2021.3.3" do
  version "2021.3.3,213.7172.1079"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.3-macos.dmg"
      sha256 "6137d77d33a8b83c0048c098246f3b4666fe35faffdb5724e945d5e7a085b35e"
  else
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.3-macos-aarch64.dmg"
      sha256 "0432578184d1c013b8f1f840a8fa48e8e6284731b7e31b5759842f42967eb7eb"
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