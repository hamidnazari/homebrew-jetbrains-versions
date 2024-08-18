cask "mps@2024.1" do
  version "2024.1,241.18034.1093"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2024.1/MPS-2024.1-macos.dmg"
      sha256 "93510db63ab6f3d7b6e139730f90836ba772032526d77e3de207e848c808d398"
  else
      url "https://download.jetbrains.com/mps/2024.1/MPS-2024.1-macos-aarch64.dmg"
      sha256 "2b070b9eb87fc910ef8b2ff96479e724f64864b6825375c272e1f7c604bbc4e7"
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