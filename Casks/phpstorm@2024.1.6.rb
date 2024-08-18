cask "phpstorm@2024.1.6" do
  version "2024.1.6,241.19072.22"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2024.1.6.dmg"
      sha256 "bb1fe2a03a24a387486c95c0959427630c9f298ac7b2f2bb2b968aa13ca6544c"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2024.1.6-aarch64.dmg"
      sha256 "028a58f3c1b8f9a73d27224eb204756fa49b8530584758c74ff64b5d5eba8239"
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