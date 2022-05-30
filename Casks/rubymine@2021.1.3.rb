cask "rubymine@2021.1.3" do
  version "2021.1.3,211.7628.26"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2021.1.3.dmg"
      sha256 "5c09ad7dbb861b58a1b2d9094b13cd4b0380f232076cf841e525d00581c45b72"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2021.1.3-aarch64.dmg"
      sha256 "e11d9e5d93e059a1582e489e4642496708f771d53e67f04e1995e6490083122e"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "mine") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/RubyMine#{version.major_minor}",
    "~/Library/Caches/RubyMine#{version.major_minor}",
    "~/Library/Logs/RubyMine#{version.major_minor}",
    "~/Library/Preferences/RubyMine#{version.major_minor}",
  ]
end