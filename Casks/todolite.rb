cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.6.0"
  sha256 arm:   "338d229eae555938b64780f736b0fa81b5da9342cc1df38484d049d5ab43819a",
         intel: "77b84fcb7e328e4d19d7cad2fd3c414439aab04bafcd62e06192479cc293efaa"

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
