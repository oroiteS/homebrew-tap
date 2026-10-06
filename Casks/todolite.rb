cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.0"
  sha256 arm:   "d969418fa6b8e0b90f30fbdae02b68caf35d0705ab24610ca9ab1a93f25f4f8c",
         intel: "369709b974019d6c93d0ccdafc294e8b45ddd6a73090a06068be9ce83bd06fdb"

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
