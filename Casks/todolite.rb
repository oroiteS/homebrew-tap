cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.6"
  sha256 arm:   "5dc88c88a7a41e3c06c0fed4e7a4159fd0edffae2644be4b39e85eed986ce20e",
         intel: "19e4f4460dafb62e625d60b2846300fb2e54049822b9ffcae4c222d5a097d8bc"

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
