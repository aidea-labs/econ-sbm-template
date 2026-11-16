#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if pgrep -f '[l]atexmk' >/dev/null 2>&1; then
  printf '检测到 LaTeX 编译任务正在运行，请等待结束后再清理。\n' >&2
  exit 1
fi

latexmk -bibtex-cond1 -e '$clean_ext .= " synctex synctex.gz";' -c "$@"

if ! command -v biber >/dev/null 2>&1; then
  printf '未找到 Biber，跳过其缓存清理。\n' >&2
  exit 0
fi

if pgrep -x biber >/dev/null 2>&1; then
  printf 'Biber 正在运行，请结束后再清理缓存。\n' >&2
  exit 1
fi

biber_cache=$(biber --cache)
if [[ ! "$biber_cache" =~ ^/.*/par-[[:xdigit:]]+/cache-[[:xdigit:]]+$ ]]; then
  printf 'Biber 缓存路径不是预期的临时目录，请手动检查：%s\n' "$biber_cache" >&2
  exit 1
fi

if [[ -L "$biber_cache" ]]; then
  printf 'Biber 缓存路径是符号链接，未自动清理：%s\n' "$biber_cache" >&2
  exit 1
fi

rm -rf -- "$biber_cache"
printf '已清理 Biber 缓存：%s\n' "$biber_cache"
