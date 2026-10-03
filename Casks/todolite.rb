cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.5"
  sha256 arm:   "984400420208ba82c40f4a89951aa1b8de0640d5d9ff045410414b8a674cda52",
         intel: "91ce9ba3d4facdb1f60c764709ebfe5cddfa15844a0298b51cff249d45d45869"

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
