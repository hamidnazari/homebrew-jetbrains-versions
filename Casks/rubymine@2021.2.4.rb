cask "rubymine@2021.2.4" do
  version "2021.2.4,212.5712.40"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2021.2.4.dmg"
      sha256 "934ae9b322e7fe12b735e4999e07835db184364c1df6492b8e0807412c40a773"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2021.2.4-aarch64.dmg"
      sha256 "e96c503004a2e83d558feb179fe6c3169b6e8d7a936d4b70a187756144bd9fb0"
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