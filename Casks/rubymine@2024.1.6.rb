cask "rubymine@2024.1.6" do
  version "2024.1.6,241.19072.21"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2024.1.6.dmg"
      sha256 "9c9bb99c91962fad9265026db760ccaa7ee04d219e76bd43a40a2989f55e3ad0"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2024.1.6-aarch64.dmg"
      sha256 "1c9519c84925011fd1636fc60fc8e85d6762a3599583afffd4caa598358e9894"
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