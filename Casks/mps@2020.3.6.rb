cask "mps@2020.3.6" do
  version "2020.3.6,203.8084.3437"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2020.3/MPS-2020.3.6-macos.dmg"
      sha256 "bc2bb0c24bfe799e1fad564b8f82519b3504f4875af76eff10d1a39318b2b0af"
  else
      url "https://download.jetbrains.com/mps/2020.3/MPS-2020.3.6-macos-aarch64.dmg"
      sha256 "aa17253f9b29c845f0aad6847294d4832cd73df8474321592fc1854db4763ebf"
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