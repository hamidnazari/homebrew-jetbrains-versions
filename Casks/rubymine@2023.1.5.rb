cask "rubymine@2023.1.5" do
  version "2023.1.5,231.9392.3"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.5.dmg"
      sha256 "1df2e961922d32f946f4295238abeff367a5ef0233298b6fbdbff4cc3eb0c8bd"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.5-aarch64.dmg"
      sha256 "7a158d33c0e6a6d7b6cfc33f1c62cf6981211750bd88ea21e779fed0c75fd565"
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