cask "rubymine@2023.3.2" do
  version "2023.3.2,233.13135.91"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.3.2.dmg"
      sha256 "061df5eda86fca0346a9dea32a7460eee8eda2347f82048149c57b88ebfcc371"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.3.2-aarch64.dmg"
      sha256 "7e966c2ee874f5385e7b712e7c01c2554dde20bf0652954e6ec0c09fcf486daa"
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