cask "datagrip@2023.3.3" do
  version "2023.3.3,233.14015.29"

  name "JetBrains DataGrip #{version.before_comma}"
  desc "Databases and SQL IDE"
  homepage "https://www.jetbrains.com/datagrip/"

  app "DataGrip.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/datagrip/datagrip-2023.3.3.dmg"
      sha256 "b65472c0767a9b880bb456022ba656a08fed4e142b5942c231d802681064afd8"
  else
      url "https://download.jetbrains.com/datagrip/datagrip-2023.3.3-aarch64.dmg"
      sha256 "96d94737eb95a9d509292e4e4b60050e8407a61f615446142ee5a2bd31e025dd"
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