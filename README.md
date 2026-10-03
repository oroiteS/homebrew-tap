# oroiteS/homebrew-tap

个人 Homebrew tap,收录自维护应用。

## 安装

```bash
brew install --cask --no-quarantine oroiteS/tap/todolite
```

或先 tap 再安装:

```bash
brew tap oroiteS/tap
brew install --cask --no-quarantine oroiteS/tap/todolite
```

> [!NOTE]
> 应用尚未做 Apple 签名与公证，`--no-quarantine` 用于跳过 Gatekeeper 隔离标记；
> 若不带该参数安装、首次打开提示「已损坏」，运行：
> `xattr -dr com.apple.quarantine /Applications/TodoLite.app`

## 当前收录

| 名称 | 类型 | 上游仓库 |
|---|---|---|
| todolite | cask | [oroiteS/todo](https://github.com/oroiteS/todo) |

## 自动同步

`.github/workflows/sync.yml` 每 30 分钟运行 `script/sync.sh`:读取各上游仓库的
最新 Release,自动更新对应 cask 的 `version` 与 `sha256` 并提交(sha256 优先取
GitHub API 的 asset `digest` 字段,缺失时下载兜底计算)。

新增应用:`Casks/` 添加 cask 文件,并在 `script/sync.sh` 的 `UPSTREAM`、
`ASSET_PREFIX` 两个映射里各加一行。
