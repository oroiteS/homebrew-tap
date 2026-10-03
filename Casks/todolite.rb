cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "914286703e321df3101361c9c7dd19be2827262df86daceca47b9b72dfd5040b",
         intel: "f70d25cafeaeb3a8442bc2e0370eba74659288bbada19b8e125764e1f9c191dd"

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
