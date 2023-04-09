cask "rubymine@2022.1.4" do
  version "2022.1.4,221.6008.14"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2022.1.4.dmg"
      sha256 "9e3f5d3b64fdb96264ba07dc39e2184db95b7283a921c29f082e2811bc97efd0"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2022.1.4-aarch64.dmg"
      sha256 "f15534a8cfd3187eed9244cdbb3bf8432fb70aaa4e7b29bfff9f67a22a60baa2"
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