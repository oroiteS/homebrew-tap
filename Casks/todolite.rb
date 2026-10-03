cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.2"
  sha256 arm:   "881e6d233f0544b61aaf83f867202df02a19477fc5177159ce4f67b15d9e7f46",
         intel: "e01375bd2e1364c832575ac7c44c28682a97cf9ab9c9c15a096c803e6cae343c"

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
