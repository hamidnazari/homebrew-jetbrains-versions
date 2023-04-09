cask "rubymine@2023.1" do
  version "2023.1,231.8109.174"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.dmg"
      sha256 "fba60e34520c807ba0a9124802e5782e2b4c8e63c27e07968b9cb642f0fc0a77"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1-aarch64.dmg"
      sha256 "56d0202ea1261eb8ac5bd24f1cb044282cda5bd6c8306d3ec606109a3fe28fba"
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