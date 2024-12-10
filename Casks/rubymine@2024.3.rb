cask "rubymine@2024.3" do
  version "2024.3,243.21565.197"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2024.3.dmg"
      sha256 "bb6a97f54a1a108f92a88152c1c4af9e6d6b85e66cff4e55038c275b3a061971"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2024.3-aarch64.dmg"
      sha256 "410f621c351b57b6fdc15391f836f45a454f2accee8d49fd60848ced3ddd4c25"
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