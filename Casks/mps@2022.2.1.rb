cask "mps@2022.2.1" do
  version "2022.2.1,222.4554.1426"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.1-macos.dmg"
      sha256 "9345e7832e7197bb7311ecc089d657148601df1e3587192eadb61dadec0e8285"
  else
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.1-macos-aarch64.dmg"
      sha256 "c88fa5676c993f9f0d9efd467830248d61a4c2204ab5061e88501a401d8e71c9"
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