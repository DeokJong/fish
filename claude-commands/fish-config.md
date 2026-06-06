fish 셸 커스터마이징 어시스턴트입니다. 환경변수, abbr/함수, 키 바인딩, 프롬프트, 플러그인 등 셸 전반을 다룹니다.

TRIGGER — 다음 중 하나라도 해당하면 다른 작업 전에 반드시 이 스킬을 먼저 로드하세요:
- fish shell 설정/커스터마이징 요청 (`config.fish`, `conf.d/`, `functions/` 등 언급)
- PATH 추가, 환경변수 설정 (`fish_add_path`, `set -gx`, `export` 언급)
- abbr/alias/함수 추가 요청
- 키 바인딩 변경 요청
- 셸 프롬프트(Starship) 수정 요청
- dotfiles 수정이 수반되는 셸 관련 작업
- "fish에서 ~가 안 된다", "fish 명령어", "fish 설정" 등 fish 관련 문제 해결
SKIP — 다른 셸(bash/zsh)만 다루는 경우

## 현재 셋업

| 항목 | 내용 |
|------|------|
| 프롬프트 | Starship (`conf.d/prompt.fish`) |
| 패키지 매니저 | Homebrew (`/home/linuxbrew/.linuxbrew`) |
| IME | fcitx (GTK/QT/SDL 환경변수 `conf.d/env.fish`) |
| 키 바인딩 | Shift+Arrow 문자 선택, Ctrl+Shift+Arrow 단어 선택 |
| dotfiles | `~/dotfiles/` — 변경 시 자동 git commit |

## 파일 구조

```
~/dotfiles/fish/               ← ~/.config/fish 심볼릭 링크
├── conf.d/
│   ├── abbr.fish              alias/abbr 단축 명령 목록
│   ├── brew.fish              환경변수: Homebrew PATH 초기화
│   ├── env.fish               환경변수: IME, 기타 set -x 선언
│   └── prompt.fish            Starship 초기화
├── functions/
│   └── fish_user_key_bindings.fish   키 바인딩
├── completions/               커스텀 자동완성
├── config.fish                메인 (거의 비어 있음 — conf.d/ 자동 로드)
└── fish_variables             universal 변수 저장소 (직접 편집 금지)
```

## 작업별 규칙

**환경변수**
- `conf.d/env.fish`에 `set -gx VAR value` 추가
- PATH는 `fish_add_path /some/bin` 사용 (중복 없이 prepend)

**alias vs abbr 선택 기준**

| 방식 | 언제 사용 | 예시 |
|------|-----------|------|
| `alias` | 단순 명령 단축 (`k` → `kubectl` 등), 바로 실행되어야 할 때 | `alias k='kubectl'` |
| `abbr` | 입력 버퍼에서 텍스트 치환이 필요할 때 (스페이스 키로 확장) | `abbr --add ga 'git add'` |

- **주의**: `abbr`는 스페이스/엔터 전까지 확장 안 됨 — `k` + 엔터로 바로 실행하려면 `alias` 사용
- 둘 다 `conf.d/abbr.fish`에 선언

**함수**
- `functions/<이름>.fish` 파일 1개 = 함수 1개 (파일명 = 함수명 필수)
- 복잡한 로직(인자 처리, 조건 분기 등)은 함수로, 단순 단축은 alias/abbr로

**키 바인딩**
- `functions/fish_user_key_bindings.fish` 내 `bind` 추가/수정
- `bind --key` 로 특수키 이름 확인: `fish_key_reader`

**자동완성**
- `completions/<명령어>.fish` 신규 파일
- `complete -c <cmd> -l <flag> -d '설명'` 형식

**프롬프트 (Starship)**
- 설정 파일: `~/.config/starship.toml`
- fish-config 범위 밖이지만 연관 작업이면 함께 처리

## 변경 후 적용

```fish
source ~/.config/fish/conf.d/<파일>.fish   # 즉시 적용
exec fish                                  # 세션 전체 재시작
```

dotfiles 변경은 자동으로 git commit됨. 리모트 push는 수동:
```fish
git -C ~/dotfiles push
```

## 변경 적용 후 필수 작업

fish 설정을 변경할 때마다 아래 두 파일을 함께 업데이트하세요:

1. **`~/dotfiles/README.md`** — 변경 내용을 해당 섹션에 반영 (환경변수 추가/삭제, abbr 추가/삭제, 함수/자동완성 추가 등)
2. **`~/dotfiles/claude-commands/fish-config.md`** (이 파일) — `## 현재 셋업` 표의 내용이 달라진 경우 업데이트

변경 유형별 수정 위치:

| 변경 | README.md | fish-config.md |
|------|-----------|----------------|
| 환경변수 추가/삭제 | 환경변수 표 | 필요 시 현재 셋업 표 |
| abbr 추가/삭제 | 약어 표 | - |
| 함수 추가/삭제 | 함수 표 | - |
| 자동완성 추가/삭제 | 자동완성 표 | - |
| PATH 추가/삭제 | 환경변수 표 | - |
| 키 바인딩 변경 | - | 현재 셋업 표 |
| 프롬프트 변경 | - | 현재 셋업 표 |

dotfiles hook이 자동 commit하므로, 파일 수정만 하면 됩니다.

## 주의

- `fish_variables` 직접 편집 금지 — `set -U`로만 조작
- `conf.d/` 는 알파벳 순 로드 — 의존 순서가 있으면 `00_`, `10_` 접두사 사용
- fish는 bash와 문법이 다름: `export` 없음 → `set -gx`, `$()` 없음 → `(cmd)`, `&&` 없음 → `; and` 또는 `cmd && cmd`(fish 3.0+는 `&&` 지원)
