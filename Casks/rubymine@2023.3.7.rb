cask "rubymine@2023.3.7" do
  version "2023.3.7,233.15325.17"

  name "JetBrains RubyMine #{version.before_comma}"
  desc "Ruby IDE"
  homepage "https://www.jetbrains.com/rubymine/"

  app "RubyMine.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/ruby/RubyMine-2023.3.7.dmg"
      sha256 "67347653bd06e761ad11c9a4cb1a6add284e193a59a377a6740a51a74b1cd391"
  else
      url "https://download.jetbrains.com/ruby/RubyMine-2023.3.7-aarch64.dmg"
      sha256 "0fb066c67cb646989ae0742d498e18087c2154034fd0303b5f81300a5b504723"
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