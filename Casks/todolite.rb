cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.0"
  sha256 arm:   "484a219757fd2bacd728aba453207fba2dd314dd05c2724b2916cdd3458c9506",
         intel: "114178e5d22dc9ab280a0f2834b5fe42963443a1dc0d997d5658b9ab94b51ec8"

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
