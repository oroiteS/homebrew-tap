cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "c7b7ac494ad47d5e6ff2602ba581d4198db2b7b44c18d325c20652553b662f56",
         intel: "87dcffe6ada8f4113335b95d15bcb9860f5e305b5e2442c332660456870b201d"

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
