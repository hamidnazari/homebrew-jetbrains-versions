cask "mps@2023.2" do
  version "2023.2,232.10072.781"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2023.2/MPS-2023.2-macos.dmg"
      sha256 "11a635432beaca5809fe0253303d07444a0bfd6fac287c72e7b03e7a9f1a59e4"
  else
      url "https://download.jetbrains.com/mps/2023.2/MPS-2023.2-macos-aarch64.dmg"
      sha256 "a19ecd8a109783e9d2260cc18f48ac97e52a0bc00ee29df5ccf711a80d1701eb"
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