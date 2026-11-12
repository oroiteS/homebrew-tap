cask "openwithpanel" do
  # version/sha256 由 OpenWithPanel 仓库的 scripts/package.sh 生成
  # （.build/dist/openwithpanel.rb），或由 script/sync.sh 依据最新 Release 自动更新
  version "0.1.1"
  sha256 "4e012aeefe512df1d6d3f688d193599befba33df54404f4050f825098fd01c85"

  url "https://github.com/oroiteS/openwithpanel/releases/download/v#{version}/OpenWithPanel-#{version}.dmg"
  name "OpenWithPanel"
  desc "Choose default apps for file types, links and extensionless files"
  homepage "https://github.com/oroiteS/openwithpanel"

  # 仅在 macOS 26 Tahoe 及以上可用
  depends_on macos: :tahoe

  livecheck do
    url :url
    strategy :github_latest
  end

  app "OpenWithPanel.app"

  # brew uninstall 不会恢复文件关联，那要靠 App 内的「卸载 OpenWithPanel…」
  uninstall quit: "net.zhaojian.openwithpanel"

  # 只做 ad-hoc 签名、未公证：brew 装完首次打开会被 Gatekeeper 拦下并提示「已损坏」。
  # 助手应用在 app bundle 内部，-r 递归一次即可一并处理。
  caveats <<~EOS
    OpenWithPanel 未经过 Apple 公证，安装后首次打开前需要执行一次：

      xattr -dr com.apple.quarantine /Applications/OpenWithPanel.app

    否则系统会提示「已损坏」，不允许打开。
  EOS

  zap trash: [
    "~/Library/Application Support/net.zhaojian.openwithpanel",
    "~/Library/Preferences/net.zhaojian.openwithpanel.plist",
  ]
end
