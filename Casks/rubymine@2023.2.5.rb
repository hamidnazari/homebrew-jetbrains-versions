cask "rubymine@2023.2.5" do
  version "2023.2.5,232.10227.6"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.2.5.dmg"
      sha256 "fffb76d5eb545ccf95146d2435deaaab978dec4e564e099058116df5decc232b"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.2.5-aarch64.dmg"
      sha256 "6ea322efc386ddfc5c55f0edb13a4ddf9c7b6179f1d61050e5d29005437d6c2b"
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