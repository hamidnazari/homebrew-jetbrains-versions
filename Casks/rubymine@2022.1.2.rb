cask "rubymine@2022.1.2" do
  version "2022.1.2,221.5787.34"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2022.1.2.dmg"
      sha256 "edea512427e73b662329bed3ed90f48041e1f2aa8bcf197c1c8cb145b8ea52de"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2022.1.2-aarch64.dmg"
      sha256 "3ac62b5839062b2f79edb71496561815dc8e509f098b78ec22b9c9b8d8690910"
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