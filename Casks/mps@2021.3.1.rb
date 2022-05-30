cask "mps@2021.3.1" do
  version "2021.3.1,213.7172.958"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.1-macos.dmg"
      sha256 "06f06e121a552a7c4ee89ecbdecb4ac7d1978ae87d6c80d04837a19e92e4f90d"
  else
      url "https://download.jetbrains.com/mps/2021.3/MPS-2021.3.1-macos-aarch64.dmg"
      sha256 "3104eb7b2a363ef9602b86a8fdca02d9b55264127f481f3eabbed65979b34791"
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