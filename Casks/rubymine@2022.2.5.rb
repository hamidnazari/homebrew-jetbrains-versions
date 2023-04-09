cask "rubymine@2022.2.5" do
  version "2022.2.5,222.4554.10"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2022.2.5.dmg"
      sha256 "f8eb395cd5d1da861b7f5b3455e14f5e91f30618be95150daa178d2d8398c7bd"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2022.2.5-aarch64.dmg"
      sha256 "2fef59862d1e455ff77854d5172e032486c4ee9ef4ba606cba289352949bc62e"
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