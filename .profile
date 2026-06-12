# shellcheck shell=bash

# If running in ksh, re-execute with bash
if [ -n "$KSH_VERSION" ]; then
    exec bash "$0" "$@"
fi

declare -a PATHSEARCH=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "/opt/bb/bin"
)

if [ -f /.dockerenv ]; then
    ENVIRONMENT=docker
elif [[ "$(uname -s)" == "Darwin" ]]; then
    ENVIRONMENT=macos
    PATHSEARCH+=(
        "/opt/homebrew/bin"
        "/usr/local/sbin"
    )
    # Add homebrew formula bins if they exist
    for bin in /opt/homebrew/opt/*/bin; do
        [[ -d "$bin" ]] && PATHSEARCH+=("$bin")
    done
elif [[ "$(uname -s)" == "Linux" ]]; then
    ENVIRONMENT=linux
else
    echo "Unknown environment: $(uname -a)"
    return 1 2>/dev/null || exit 1
fi

export ENVIRONMENT=$ENVIRONMENT

echo "Running .profile for $SHELL in $ENVIRONMENT"

# Find installed binaries, irrespective of the platform
for bin in "${PATHSEARCH[@]}";
do
    if [[ -d "$bin" ]]; then
        export PATH=$PATH:$bin
    fi
done

PROFILEDIR=$(realpath ~/.profile.d)

if [[ -n "$CLAUDECODE" ]]; then
    echo "Skipping .profile.d scripts (Claude Code 🤖 session)"
    return 0 2>/dev/null
fi

# Process .profile.d scripts in the following order:
#   1. cross-platform
#   2. shell-specific
#   3. environment-specific
#
for folder in ${PROFILEDIR}{,/$(basename "$SHELL"),/${ENVIRONMENT}}; do
    if [[ ! -d $folder ]]; then
        continue
    fi

    for script in "$folder"/*.sh; do
        if [[ -f  "$script" ]]; then
            NAME=${script#"$PROFILEDIR"}
            NAME=${NAME%".sh"}

            # shellcheck source=/dev/null
            if source "$script"; then
              echo "✅ ${NAME:1}"
            else
              echo "❌ ${NAME:1}"
            fi
        fi
    done
done
