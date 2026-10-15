cask "feiwu" do
  # version/sha256 由 script/sync.sh 依据 oroiteS/quark-downloader 最新
  # Release 自动更新；0.0.0 + 空串 sha256 为占位，首个真实 Release 发布
  # 后 30 分钟内自动填充（sync.yml 定时任务）。
  version "0.1.0"
  sha256 "38335705c8207f80302a1ebfa0f18d9ec72c089a7bec70fd95e483a3c91144a4"

  url "https://github.com/oroiteS/quark-downloader/releases/download/v#{version}/feiwu-v#{version}-macos-universal.dmg"
  name "飞舞"
  desc "夸克网盘分享链接解析下载器"
  homepage "https://github.com/oroiteS/quark-downloader"

  # 不声明 auto_updates：上游无自更新机制，如实以保证 brew upgrade 可达
  depends_on macos: ">= :big_sur"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "feiwu.app"

  # 数据目录对齐 internal/store/paths.go（macOS 平台默认 UserConfigDir/feiwu）
  zap trash: [
    "~/Library/Application Support/feiwu",
    "~/Library/WebKit/com.feiwu.downloader",
  ]
end
