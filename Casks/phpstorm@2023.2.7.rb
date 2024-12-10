cask "phpstorm@2023.2.7" do
  version "2023.2.7,232.10335.8"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.2.7.dmg"
      sha256 "bad65d6c6f7ee0ccd01103cae666fcf6a070c3b1a9d248468c1092d49e783b95"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.2.7-aarch64.dmg"
      sha256 "c43d43729631579d6108275bfc79648e92274f00c9eb25138a9aa38be42e1cea"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "pstorm") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/PhpStorm#{version.major_minor}",
    "~/Library/Caches/PhpStorm#{version.major_minor}",
    "~/Library/Logs/PhpStorm#{version.major_minor}",
    "~/Library/Preferences/jetbrains.phpstorm.*.plist",
    "~/Library/Preferences/PhpStorm#{version.major_minor}",
  ]
end