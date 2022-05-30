cask "phpstorm@2020.3.3" do
  version "2020.3.3,203.7717.64"

  name "JetBrains PhpStorm #{version.before_comma}"
  desc "PHP IDE"
  homepage "https://www.jetbrains.com/phpstorm/"

  app "PhpStorm.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/webide/PhpStorm-2020.3.3.dmg"
      sha256 "3c72eea3d7da78e9183d7f3e64de69bb577aeaabb0e595044837517545d5e1a4"
  else
      url "https://download.jetbrains.com/webide/PhpStorm-2020.3.3-aarch64.dmg"
      sha256 "b0538762e97c0d35e0452d78373d406aec6ac20151b21f4dd5f9ce8e510bf7c4"
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