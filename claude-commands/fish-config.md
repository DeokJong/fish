# Fish Shell 설정 관리

`~/.config/fish/` 하위 파일들을 읽고, 편집하고, 추가하는 스킬입니다.

## 디렉토리 구조

```
~/.config/fish/
├── config.fish                          # 메인 설정 (conf.d/가 자동 로드되므로 거의 비어 있음)
├── fish_variables                       # fish 내부 범용 변수 (직접 편집하지 말 것)
├── conf.d/                              # 자동 로드되는 설정 조각
│   ├── brew.fish                        # Homebrew 초기화
│   ├── env.fish                         # 환경변수 (GTK_IM_MODULE 등 fcitx 관련)
│   └── prompt.fish                      # Starship 프롬프트 초기화
├── functions/                           # fish 함수 정의
│   └── fish_user_key_bindings.fish      # 키 바인딩 (Shift+Arrow 선택, Ctrl+Shift+Arrow 단어 선택)
└── completions/                         # 커스텀 자동완성 정의
```

## 파일별 역할

| 파일 | 용도 |
|------|------|
| `conf.d/env.fish` | `set -x` 환경변수 선언. fcitx IME 변수 포함 |
| `conf.d/brew.fish` | `/home/linuxbrew/.linuxbrew/bin/brew shellenv` 평가 |
| `conf.d/prompt.fish` | `starship init fish \| source` |
| `functions/fish_user_key_bindings.fish` | `fish_user_key_bindings` 함수 — 키 바인딩 정의 |

## 작업 유형별 파일 선택 기준

- **환경변수 추가** → `conf.d/env.fish`에 `set -x VAR value` 추가
- **alias / 약어 추가** → `conf.d/` 하위 새 `.fish` 파일 생성하거나 기존 파일 편집  
  (약어는 `abbr --add` 사용)
- **새 함수 정의** → `functions/<함수이름>.fish` 신규 파일 (fish는 함수 이름 = 파일 이름 규칙)
- **키 바인딩 변경** → `functions/fish_user_key_bindings.fish` 내 `bind` 라인 수정
- **자동완성 추가** → `completions/<명령어>.fish` 신규 파일
- **시작 시 실행 코드** → `conf.d/` 하위 새 `.fish` 파일 (알파벳 순 로드됨)

## 편집 후 적용

변경 사항은 새 fish 세션에서 자동 반영됩니다.  
현재 세션에 즉시 적용하려면:

```fish
source ~/.config/fish/conf.d/<파일명>.fish   # 특정 파일
# 또는
exec fish                                    # 세션 재시작
```

## 주의사항

- `fish_variables`는 `set -U` (universal variable) 저장소이므로 직접 편집하지 말 것
- `conf.d/` 파일은 알파벳 순으로 로드되므로 의존 관계가 있으면 파일 이름 앞에 숫자 접두사 사용 (`00_`, `10_` 등)
- 함수 파일은 반드시 파일 이름과 함수 이름이 일치해야 자동 로드됨
