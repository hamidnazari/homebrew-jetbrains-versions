cask "rubymine@2024.2.5" do
  version "2024.2.5,242.24807.16"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2024.2.5.dmg"
      sha256 "762b1c2fe9a39c0a1f8bb0395df700eb80d23c91999bc51ad84a4f21b355e2ab"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2024.2.5-aarch64.dmg"
      sha256 "9af7cc9eadd2fa37773d0bc8aad7a34d763bedbb9a12daf4bfa9eccfd806b5bf"
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