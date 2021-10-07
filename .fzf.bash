# Setup fzf
# ---------
if [[ ! "$PATH" == */$HOME/.fzf/bin* ]]; then
	export PATH="${PATH:+${PATH}:}/$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/$HOME/.fzf/shell/key-bindings.bash"

is_in_git_repo() {
	git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
	fzf --height 50% "$@" --border
}


gb() {
	is_in_git_repo || return
	git branch -a --color=always | grep -v '/HEAD\s' | sort |
		fzf-down --ansi --multi --tac --preview-window right:70% \
		--preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
		sed 's/^..//' | cut -d' ' -f1 |
		sed 's#^remotes/##'
}

bind '"\C-g\C-b": "$(gb)\e\C-e\er"'

export FZF_DEFAULT_OPTS="--color=bg+:#262626,info:15,header:#ff0000,marker:15,prompt:15,fg:245,spinner:15,hl:15,pointer:15,hl+:15 --multi --bind='alt-t:toggle-all'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_complete_psql() {
  _fzf_complete --multi --reverse --prompt="psql> " -- "$@" < <(
		echo "postgresql://aes:aes@toll-an-db0.cloud.cyber.ee"
		echo "postgresql://aes:aes@toll-an-db1.cloud.cyber.ee"
		echo "postgresql://menutest:menutest@toll-postgres.cyber.ee"
		echo "postgresql://impulss:test@toll-an-db0.cloud.cyber.ee"
		echo "postgresql://impulss:test@toll-an-db1.cloud.cyber.ee"
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_psql -o default -o bashdefault psql

function git_create_branch() {
  local jq_template branch_name
  jq_template='"'\
'RM\(.id). \(.subject)'\
'\t'\
'Reporter: \(.author["@name"])\n'\
'Created: \(.created_on)\n'\
'Updated: \(.updated_on)\n\n'\
'Description: \(.description)\n'\
'"'
  branch_name=$(
		curl -n -s 'https://rm-int.cyber.ee/ito/issues.xml?query_id=664&limit=1000' | xq | \
    jq ".issues | .issue[] | $jq_template" |
    sed -e 's/"\(.*\)"/\1/' -e 's/\\t/\t/' |
    fzf \
      --with-nth=1 \
      --delimiter='\t' \
      --preview='echo -e {2}' \
      --preview-window=top:wrap |
    cut -f1 |
    sed -e 's/\. /\t/' -e 's/ä/a/gi' -e 's/ö/o/gi' -e 's/õ/o/gi' -e 's/ü/u/gi' -e 's/[^a-zA-Z0-9\t]/-/g' -e 's/-\+/-/g' -e 's/-\+$//' |
    awk '{printf "%s/%s", $1, tolower($2)}'
  )

  if [ -n "$branch_name" ]; then
		git checkout -b "$branch_name"
  fi
}
