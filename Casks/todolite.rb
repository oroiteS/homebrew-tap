cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.2"
  sha256 arm:   "a672665c2cb6e958a069d29b0cd3f7c016cca0988f8f3a2dec0f32720296fff4",
         intel: "156f59d1ec0813e5a79855fb225f91e9b6a76dc94054af61826e0b05bb7ceb65"

  url "https://github.com/oroiteS/todo/releases/download/v#{version}/TodoLite_#{version}_#{arch}.dmg"
  name "TodoLite"
  desc "Lightweight and beautiful cross-platform todo list"
  homepage "https://github.com/oroiteS/todo"

  depends_on :macos

  livecheck do
    url :url
    strategy :github_latest
  end

  app "TodoLite.app"

  zap trash: [
    "~/Library/Application Support/com.syn.todolite",
    "~/Library/Caches/com.syn.todolite",
    "~/Library/Preferences/com.syn.todolite.plist",
    "~/Library/Saved Application State/com.syn.todolite.savedState",
    "~/Library/WebKit/com.syn.todolite",
  ]
end
