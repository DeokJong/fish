#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "${dst}.bak"
        echo "백업: ${dst}.bak"
    fi
    ln -sfn "$src" "$dst"
    echo "링크: $dst -> $src"
}

link "$DOTFILES/fish"                       "$HOME/.config/fish"
link "$DOTFILES/claude-skills/fish-config.md" "$HOME/.claude/skills/fish-config.md"

echo "완료"
