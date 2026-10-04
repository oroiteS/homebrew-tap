cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.4"
  sha256 arm:   "a6de583132616bd07cc3d7fc9792da980266b33de90b83757f407712e6841d63",
         intel: "c6b60686c2d174e1e9931257f990344c41c05e631b1639537f5902e7e5a2f850"

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
