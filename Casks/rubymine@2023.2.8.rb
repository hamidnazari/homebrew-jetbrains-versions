cask "rubymine@2023.2.8" do
  version "2023.2.8,232.10335.14"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.2.8.dmg"
      sha256 "500ac1c1cefdd03934ea26bf82995f32b8a318e76fd0feb2cb6daa0a116d0c53"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.2.8-aarch64.dmg"
      sha256 "7be46cd4f3617c5760614a9c2dfc5ce2e9232be89d0d688a0a37a2d934e0819e"
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