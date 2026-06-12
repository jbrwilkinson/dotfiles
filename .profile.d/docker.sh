# shellcheck shell=bash

[[ "$(command -v docker)" == "" ]] && return 1

alias dc="docker compose"
alias dcb="docker compose build --pull"
alias dcd="docker compose down --remove-orphans"
alias dcr="docker compose run --rm"
