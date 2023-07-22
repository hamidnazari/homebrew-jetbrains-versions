cask "rubymine@2023.1.4" do
  version "2023.1.4,231.9225.12"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.4.dmg"
      sha256 "4ade59a9d04cc4b5e0a4ed62c2c60e8ddba9717ae91a3e8cf53363d8f0a41e29"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.4-aarch64.dmg"
      sha256 "ddcb8bf654c24daa0365b9e734b9c6b6d0238303d0f8f540d6e1ce821539e59e"
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