cask "rubymine@2023.2.7" do
  version "2023.2.7,232.10319.10"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.2.7.dmg"
      sha256 "ae5cd63da0db04ca1a659cc5243ec9838182977cce89ff695844b0228494e5fe"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.2.7-aarch64.dmg"
      sha256 "91fc92ecc2a8dc7b30c8360b06c6a9a11bb7301c4c346cc23504d168739b8dbb"
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