cask "rubymine@2022.3.3" do
  version "2022.3.3,223.8836.42"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2022.3.3.dmg"
      sha256 "f6583f4c9b9cb3fb1079968565c3f65f6a05329724e1dbb5c29ac348fc86cd9d"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2022.3.3-aarch64.dmg"
      sha256 "317c9bd172cf7484d57781fafe8d317f6e1478141bbe30ac364aaa48a0cdc692"
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