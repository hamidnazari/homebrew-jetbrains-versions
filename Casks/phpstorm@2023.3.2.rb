cask "phpstorm@2023.3.2" do
  version "2023.3.2,233.13135.108"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2023.3.2.dmg"
      sha256 "a55592cd5e6122f75446588f7c1ea5372aed2f16bab7e188e53291e697ac04ae"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2023.3.2-aarch64.dmg"
      sha256 "10713f0b4c8741bd940c650a3e2b084f69d7e3e7e910d81e6b52bd30545407e9"
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