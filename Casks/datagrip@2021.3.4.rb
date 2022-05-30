cask "datagrip@2021.3.4" do
  version "2021.3.4,213.6777.22"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2021.3.4.dmg"
      sha256 "27e709d2ced66d37a615d8c56885828e49a08962708e28df1a20f324c626bf52"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2021.3.4-aarch64.dmg"
      sha256 "7a77ba9fce56c781ae6a4fc65eaab4bcc10780b6bd679b04d74146719e42890a"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "datagrip") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/DataGrip*",
    "~/Library/Caches/JetBrains/DataGrip*",
    "~/Library/Logs/JetBrains/DataGrip*",
    "~/Library/Saved Application State/com.jetbrains.datagrip.savedState",
  ]
end