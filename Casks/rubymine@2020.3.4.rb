cask "rubymine@2020.3.4" do
  version "2020.3.4,203.8084.28"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2020.3.4.dmg"
      sha256 "94fb022320b2e41245094af9be6328b7d37ebe6044f8e9147e531462e7acf801"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2020.3.4-aarch64.dmg"
      sha256 "623ef9602c186ff339e9d3aa231dd0338babd0fffd9602b516eaa21a4a8f157f"
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