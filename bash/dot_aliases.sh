# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias l='exa -ll --color=always --group-directories-first'
alias ls='exa -al --header --icons --group-directories-first'

alias idea='nohup /home/erick/dev/tools/idea-IU-252.26830.84/bin/idea > /tmp/idea.log 2>&1 &'
alias awsc='python3 /home/erick/dev/projects/zatlas/zatlas-commands/python/update_aws_credentials.py'

alias cs='xclip -selection clipboard'       #copy to clipboard. ex: echo 123 | cs
alias vs='xclip -o -selection clipboard'    #paste from clipboard.
alias cs_from_file='xclip -selection clipboard <'    # Copy file content to clipboard. Usage: cs_from_file filename
alias vs_into_file='xclip -o -selection clipboard >'  # Paste clipboard into a file. Usage: vs_into_file filename

# Query Runner - PostgreSQL query management tool
alias qr="/home/erick/dev/venv/bin/qr"

alias tracker='/home/erick/dev/projects/personal/bimester-tracker/.venv/bin/tracker'
#alias jt='/home/erick/bin/jtd'
alias jt='java -jar /home/erick/dev/projects/personal/jvm-test-daemon/jtd-cli/build/libs/jtd.jar'

alias fd=fdfind
alias fda='fdfind --no-ignore --hidden'
alias awscli='python /home/erick/dev/projects/zatlas/zatlas-commands/python/update_aws_credentials.py'

alias claude-mem='/home/erick/.bun/bin/bun "/home/erick/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# Set WezTerm tab title (usable by Claude Code or manually)
alias tabtitle='wezterm cli set-tab-title'
