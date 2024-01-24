cask "mps@2022.3.1" do
  version "2022.3.1,223.8836.1366"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3.1-macos.dmg"
      sha256 "87ab59549a73e943fb7386a3ac7755852cd663599303c5d1e7b8c1aa2398cb44"
  else
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3.1-macos-aarch64.dmg"
      sha256 "39dd6e9bc93cee7f4dfbebd44620a981ed4157778dfc0461c88cb51a65d83798"
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