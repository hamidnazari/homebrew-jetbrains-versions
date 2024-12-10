cask "rubymine@2024.1.7" do
  version "2024.1.7,241.19416.14"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2024.1.7.dmg"
      sha256 "85acad5692cdf04f822b24f6b8ef690e328a7d7b8cb8c2fa1d28d7051ff0e1ec"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2024.1.7-aarch64.dmg"
      sha256 "d3071551a9f7915033899257e212bb71a94decf3443c9e7aa1ea7e616203c541"
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