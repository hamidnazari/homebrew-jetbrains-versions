cask "mps@2024.1.1" do
  version "2024.1.1,241.19072.1155"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2024.1/MPS-2024.1.1-macos.dmg"
      sha256 "85f936a8d4a610b0232f5716f364cfae6edac5322fd40714c07e9ffabb11e85a"
  else
      url "https://download.jetbrains.com/mps/2024.1/MPS-2024.1.1-macos-aarch64.dmg"
      sha256 "381b6c527f444ca2ea652054e172afee2096c29ad445cec7fa7fe6432cb41bea"
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