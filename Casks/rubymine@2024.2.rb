cask "rubymine@2024.2" do
  version "2024.2,242.20224.338"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2024.2.dmg"
      sha256 "9a696ca11f887f39e1721e1c0553d77fbef83c9b9fdcb37e8bbfd73d7a04e923"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2024.2-aarch64.dmg"
      sha256 "aa30af9a86bab793c319bc434416c533f3b96018822a8173941a0d5222795207"
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