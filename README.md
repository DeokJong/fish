# dotfiles

## Fish Shell 설정

`~/dotfiles/fish/` → `~/.config/fish/` 심볼릭 링크

### conf.d/

| 파일 | 역할 |
|------|------|
| `brew.fish` | Homebrew PATH 초기화 |
| `env.fish` | 환경변수 (AWS, IME, JetBrains Toolbox PATH) |
| `prompt.fish` | Starship 프롬프트 초기화 |
| `abbr.fish` | alias/abbr 단축 명령 목록 |

### 환경변수 (`conf.d/env.fish`)

| 변수 | 값 |
|------|----|
| `AWS_DEFAULT_REGION` | `ap-northeast-2` |
| `GTK_IM_MODULE` | `fcitx` |
| `QT_IM_MODULE` | `fcitx` |
| `XMODIFIERS` | `@im=fcitx` |
| `SDL_IM_MODULE` | `fcitx` |
| PATH | `~/.local/share/JetBrains/Toolbox/scripts` |

### 약어 (`conf.d/abbr.fish`)

| 약어 | 확장 |
|------|------|
| `kubectl` | `k` |

### 함수 (`functions/`)

| 파일 | 역할 |
|------|------|
| `assume.fish` | AWS granted assume 래퍼 |
| `k9s.fish` | k9s 실행 시 로케일 강제 (`en_US.utf8`) |
| `fish_user_key_bindings.fish` | 키 바인딩 (Shift+Arrow 선택, Ctrl+Shift+Arrow 단어 선택) |

### 자동완성 (`completions/`)

| 파일 | 대상 |
|------|------|
| `aws.fish` | AWS CLI |
| `granted.fish` | granted CLI |

## Claude Commands

`~/dotfiles/claude-commands/` → `~/.claude/commands/` 심볼릭 링크

| 스킬 | 역할 |
|------|------|
| `fish-config.md` | Fish shell 커스터마이징 어시스턴트 |
