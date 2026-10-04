cask "todolite" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.5"
  sha256 arm:   "2bef252059b4c1cdc03dd8dd222acca9baf6ed6960558d2ba6bc074e88ee725f",
         intel: "ee4d2f327e605f70b3c3018b9dc4fcd8f125d7ec2324788b262848edb3f05386"

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
