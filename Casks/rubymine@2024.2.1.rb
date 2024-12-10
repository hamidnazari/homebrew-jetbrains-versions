cask "rubymine@2024.2.1" do
  version "2024.2.1,242.21829.150"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2024.2.1.dmg"
      sha256 "3bc2e6e43fae8f799c4a5d42a4c33d9ae13039b40e7c28bd010a77c5cb8e421f"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2024.2.1-aarch64.dmg"
      sha256 "feca00900fc89e03c92a12d2643e927daa47eb026db2bf635b058c5e292a45a4"
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