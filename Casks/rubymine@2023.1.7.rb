cask "rubymine@2023.1.7" do
  version "2023.1.7,231.9423.3"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.7.dmg"
      sha256 "168f147e5fd8c5f36d93e62448d36074790a961360c20c87098e318e14462a47"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.1.7-aarch64.dmg"
      sha256 "125e7429f889886f64132c3f35f6908f31db5ae0f86e40630eac22f2dc10dc1f"
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