cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.9.0"
  sha256 arm:   "557e7f08d6d46a9c87339379109afc0f3e612d254a9bb08b49ee5c258e1266bc",
         intel: "8b670c3682dbce2651ea394573fb260712e1f2674e30fcb156f9af464c13baf1"

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
