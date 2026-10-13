cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.7.0"
  sha256 arm:   "879b9109736ede15ce60a3d71eff6b61497947651a1a69fdea4de07fbb2db7c2",
         intel: "f00c9cec6a9a273b6bd94cfa62e907f8bb73efa0226cf9e5e31f287b426bd47a"

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
