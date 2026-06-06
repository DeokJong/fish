fish 셸 커스터마이징 어시스턴트입니다. 환경변수, abbr/함수, 키 바인딩, 프롬프트, 플러그인 등 셸 전반을 다룹니다.

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

**abbr (약어) — alias 대신 사용**
```fish
abbr --add g git
abbr --add ga 'git add'
```
- `conf.d/` 하위 파일에 선언하거나 `abbr --add` 실행 (universal variable로 저장됨)
- 새 카테고리면 `conf.d/abbr.fish` 파일 새로 생성

**함수**
- `functions/<이름>.fish` 파일 1개 = 함수 1개 (파일명 = 함수명 필수)
- 복잡한 로직은 함수로, 단순 단축은 abbr로

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

## 주의

- `fish_variables` 직접 편집 금지 — `set -U`로만 조작
- `conf.d/` 는 알파벳 순 로드 — 의존 순서가 있으면 `00_`, `10_` 접두사 사용
- fish는 bash와 문법이 다름: `export` 없음 → `set -gx`, `$()` 없음 → `(cmd)`, `&&` 없음 → `; and` 또는 `cmd && cmd`(fish 3.0+는 `&&` 지원)
