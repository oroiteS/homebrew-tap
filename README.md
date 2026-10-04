# oroiteS/homebrew-tap

个人 Homebrew tap,收录自维护应用。

## 收录应用

### todolite

轻量、好看、跨平台(macOS / Windows / Android)的待办清单,上游
[oroiteS/todo](https://github.com/oroiteS/todo)。

安装:

```bash
brew install --cask oroiteS/tap/todolite
xattr -dr com.apple.quarantine /Applications/TodoLite.app
```

或先 tap 再安装:

```bash
brew tap oroiteS/tap
brew install --cask oroiteS/tap/todolite
xattr -dr com.apple.quarantine /Applications/TodoLite.app
```

> [!NOTE]
> 应用尚未做 Apple 签名与公证。brew 7 已移除 `--no-quarantine` 选项
> （Homebrew 4.7.0 起弃用），无法在安装时跳过隔离标记，所以安装后
> **就是要执行一次** `xattr -dr com.apple.quarantine /Applications/TodoLite.app`
> 去掉 Gatekeeper 隔离标记，否则首次打开提示「已损坏」。

## 自动同步

`.github/workflows/sync.yml` 按 cron `*/30 * * * *`(即每 30 分钟)运行
`script/sync.sh`:读取各上游仓库的最新 Release,自动更新对应 cask 的 `version`
与 `sha256` 并提交(sha256 优先取 GitHub API 的 asset `digest` 字段,缺失时
下载兜底计算)。

注意 GitHub Actions 的 schedule 只是尽力而为:整点/半点是全网高峰,延迟甚至
整次跳过很常见,实际往往几小时才轮到一次。好在脚本幂等、每次都与最新 Release
对账,漏掉中间槽位不影响正确性;等不及就在 Actions 页手动 Run workflow
(已启用 `workflow_dispatch`)。

新增应用:`Casks/` 添加 cask 文件,并在 `script/sync.sh` 的 `UPSTREAM`、
`ASSET_PREFIX` 两个映射里各加一行,最后在「收录应用」按同样格式加一节。
