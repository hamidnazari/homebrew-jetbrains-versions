cask "rubymine@2021.3.3" do
  version "2021.3.3,213.7172.23"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2021.3.3.dmg"
      sha256 "3d9a6fb042f4cb02a83947376c433819dfed1405904216c91aaa388a131b5692"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2021.3.3-aarch64.dmg"
      sha256 "d84d57766f6280070cb5c494751576a8843fab71fe4605d18653e1513fdff230"
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