function fish_prompt --description 'Write out the prompt'
    set_color E60073
    printf '['
    printf '%s' (whoami)
    printf '@'
    printf '%s' (hostname)
    printf ':'
    printf '%s' (pwd)
    printf ']\U25b6 '
    set_color normal
end