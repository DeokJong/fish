function fish_user_key_bindings
    # Shift+Arrow: 문자 단위 선택
    bind shift-right 'commandline -f begin-selection forward-char'
    bind shift-left  'commandline -f begin-selection backward-char'
    bind shift-up    'commandline -f begin-selection up-line'
    bind shift-down  'commandline -f begin-selection down-line'

    # Ctrl+Shift+Arrow: 단어 단위 선택 (물리 Alt+Shift+Arrow)
    bind ctrl-shift-right 'commandline -f begin-selection forward-word'
    bind ctrl-shift-left  'commandline -f begin-selection backward-word'

    # Escape: 선택 해제
    bind escape 'commandline -f cancel-commandline'
end
