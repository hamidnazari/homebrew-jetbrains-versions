cask "rubymine@2023.3.8" do
  version "2023.3.8,233.15619.11"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.3.8.dmg"
      sha256 "dcb915a6d66e1f49a03fa3dd0d3300d28234a13486f3022d729fece827e8ea44"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.3.8-aarch64.dmg"
      sha256 "ced1c630d99d1538faf528be8b274f5079fcdb2832ece4fd61d855317eb42cc3"
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