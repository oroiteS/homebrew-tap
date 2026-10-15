#!/usr/bin/env bash
# 读取各上游仓库的最新 Release,自动更新对应 cask 的 version/sha256 并提交。
# 新增应用:Casks/ 加 cask 文件,并在下面两个映射里各加一行。
set -euo pipefail

declare -A UPSTREAM=(
  [todolite]="oroiteS/todo"
  [feiwu]="oroiteS/quark-downloader"
)
declare -A ASSET_PREFIX=(
  [todolite]="TodoLite"   # 资产命名:TodoLite_<版本>_aarch64.dmg / _x64.dmg
)
# universal 单文件资产(单 sha256):ASSET_TEMPLATE 里写完整资产名模板。
declare -A ASSET_TEMPLATE=(
  [feiwu]="feiwu-v{version}-macos-universal.dmg"
)

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

changed=0
for token in "${!UPSTREAM[@]}"; do
  repo="${UPSTREAM[$token]}"
  file="Casks/$token.rb"
  [[ -f $file ]] || { echo "::warning::$file 不存在,跳过 $token"; continue; }

  # 上游暂无 release(如仓库刚转公开、首版未发)时安全跳过,不阻断其他 cask
  tag=$(gh api "repos/$repo/releases/latest" --jq .tag_name 2>/dev/null) || true
  if [[ -z ${tag:-} ]]; then
    echo "::warning::$repo 暂无 release,跳过 $token"
    continue
  fi
  version="${tag#v}"
  if grep -q "version \"$version\"" "$file"; then
    echo "$token: 已是 $version,无需更新"
    continue
  fi

  # universal 单 sha256 分支:取模板资产的单 digest,替换单行 sha256
  if [[ -n ${ASSET_TEMPLATE[$token]:-} ]]; then
    asset="${ASSET_TEMPLATE[$token]//\{version\}/$version}"
    sha=$(gh api "repos/$repo/releases/latest" --jq \
      ".assets[] | select(.name == \"$asset\") | .digest // empty" \
      | head -n1 | sed 's/^sha256://')
    if [[ -z $sha ]]; then   # 老资产可能没有 digest 字段,下载兜底
      sha=$(curl -fsSL "https://github.com/$repo/releases/download/$tag/$asset" | shasum -a 256 | awk '{print $1}')
    fi
    [[ -n $sha ]] || { echo "::error::$token $version 缺少 sha256"; exit 1; }

    sed -i.bak \
      -e "s/^  version \".*\"$/  version \"$version\"/" \
      -e "s/^  sha256 \"[0-9a-f]*\"$/  sha256 \"$sha\"/" \
      "$file"
    rm -f "$file.bak"

    git add "$file"
    git commit -q -m "bump $token to $version"
    echo "$token: $version (universal=$sha)"
    changed=1
    continue
  fi

  arm=$(gh api "repos/$repo/releases/latest" --jq \
    ".assets[] | select(.name | endswith(\"_${version}_aarch64.dmg\")) | .digest // empty" \
    | head -n1 | sed 's/^sha256://')
  intel=$(gh api "repos/$repo/releases/latest" --jq \
    ".assets[] | select(.name | endswith(\"_${version}_x64.dmg\")) | .digest // empty" \
    | head -n1 | sed 's/^sha256://')

  prefix="${ASSET_PREFIX[$token]}"
  if [[ -z $arm ]]; then   # 老资产可能没有 digest 字段,下载兜底
    arm=$(curl -fsSL "https://github.com/$repo/releases/download/$tag/${prefix}_${version}_aarch64.dmg" | shasum -a 256 | awk '{print $1}')
  fi
  if [[ -z $intel ]]; then
    intel=$(curl -fsSL "https://github.com/$repo/releases/download/$tag/${prefix}_${version}_x64.dmg" | shasum -a 256 | awk '{print $1}')
  fi
  [[ -n $arm && -n $intel ]] || { echo "::error::$token $version 缺少 sha256(arm=$arm intel=$intel)"; exit 1; }

  sed -i.bak \
    -e "s/^  version \".*\"$/  version \"$version\"/" \
    -e "s/sha256 arm:   \"[0-9a-f]*\"/sha256 arm:   \"$arm\"/" \
    -e "s/^         intel: \"[0-9a-f]*\"$/         intel: \"$intel\"/" \
    "$file"
  rm -f "$file.bak"

  git add "$file"
  git commit -q -m "bump $token to $version"
  echo "$token: $version (arm=$arm intel=$intel)"
  changed=1
done

[[ $changed == 1 ]] && git push
echo "sync done"
