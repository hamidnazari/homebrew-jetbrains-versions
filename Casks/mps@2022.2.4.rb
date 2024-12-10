cask "mps@2022.2.4" do
  version "2022.2.4,222.4554.1739"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.4-macos.dmg"
      sha256 "d078ad25eddf8e27b5ff1727e3c9c500a29ff180b9e0b947bef243e8ec5f4724"
  else
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.4-macos-aarch64.dmg"
      sha256 "7718362c21279623acd921547bc4b2d10a6f0418f9bdb6eb334a85740d7038a3"
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