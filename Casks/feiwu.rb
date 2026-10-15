cask "feiwu" do
  # version/sha256 由 script/sync.sh 依据 oroiteS/quark-downloader 最新
  # Release 自动更新；0.0.0 + 空串 sha256 为占位，首个真实 Release 发布
  # 后 30 分钟内自动填充（sync.yml 定时任务）。
  version "0.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  url "https://github.com/oroiteS/quark-downloader/releases/download/v#{version}/feiwu-v#{version}-macos-universal.dmg"
  name "飞舞"
  desc "夸克网盘分享链接解析下载器"
  homepage "https://github.com/oroiteS/quark-downloader"

  auto_updates true
  depends_on macos: ">= :big_sur"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "feiwu.app"

  # 数据目录对齐 store/paths.go（macOS 平台默认 UserConfigDir/feiwu）
  zap trash: "~/Library/Application Support/feiwu"
end
