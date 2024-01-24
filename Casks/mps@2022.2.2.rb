cask "mps@2022.2.2" do
  version "2022.2.2,222.4554.1547"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.2-macos.dmg"
      sha256 "507eae1670942527fb12c6712e3deaf301075a9d2811e71a36567967377646a1"
  else
      url "https://download.jetbrains.com/mps/2022.2/MPS-2022.2.2-macos-aarch64.dmg"
      sha256 "29e65eebe94908eb27adfa307e5d7ff4a15936caf351a13826ec6c3596c1131e"
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