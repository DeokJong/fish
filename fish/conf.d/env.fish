# 환경변수
set -x AWS_DEFAULT_REGION ap-northeast-2

# Terragrunt
set -gx TERRAGRUNT_CACHE_DIR ~/.cache/terragrunt
set -gx TERRAGRUNT_DOWNLOAD_DIR ~/.cache/terragrunt/downloads
set -gx KUBE_EDITOR 'zed --wait'

# JetBrains Toolbox
fish_add_path ~/.local/share/JetBrains/Toolbox/scripts

set -x GTK_IM_MODULE fcitx
set -x QT_IM_MODULE fcitx
set -x XMODIFIERS @im=fcitx
set -x SDL_IM_MODULE fcitx
