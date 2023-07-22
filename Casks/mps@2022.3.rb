cask "mps@2022.3" do
  version "2022.3,223.8836.1185"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3-macos.dmg"
      sha256 "17cb973af11118c246d4144ba0071ce31fe3f276be7029f613cdb0fa60b752cc"
  else
      url "https://download.jetbrains.com/mps/2022.3/MPS-2022.3-macos-aarch64.dmg"
      sha256 "40d8a928a1c1703544c9905a3f8e6a7d0ade3b17302782da2ed68fd1dcdafef9"
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