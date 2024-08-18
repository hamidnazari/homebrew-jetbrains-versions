cask "mps@2023.2.1" do
  version "2023.2.1,232.10300.938"

  name "JetBrains MPS #{version.before_comma}"
  desc "Domain-specific Languages IDE"
  homepage "https://www.jetbrains.com/mps/"

  app "MPS.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/mps/2023.2/MPS-2023.2.1-macos.dmg"
      sha256 "6e8cb6bbabd75b037d8230a5cb1bfaff0be4e76029950e06cd62165bfc04864f"
  else
      url "https://download.jetbrains.com/mps/2023.2/MPS-2023.2.1-macos-aarch64.dmg"
      sha256 "2a4bf80db03d0c1dd64d83ea3678d47a232b6b040f5dd8b80dac98c07bb7982f"
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