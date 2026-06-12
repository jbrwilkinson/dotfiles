#!/usr/bin/env bash

# Don't assume the install location
DOTFILES=$(dirname "$(realpath "$0")")

cd ~ || exit 99

# Folders where we symlink individual items inside rather than the folder itself
SPECIAL_DIRS=(.config .claude)

# Build exclusion flags for special dirs and other top-level items we don't want to symlink
EXCLUDE_ARGS=(-name ".git" -o -name ".dotfiles")
for dir in "${SPECIAL_DIRS[@]}"; do
    EXCLUDE_ARGS+=(-o -name "$dir")
done

# Symlink top-level dotfiles (excluding special dirs)
find "${DOTFILES}" -maxdepth 1 -name ".??*" \
    -not \( "${EXCLUDE_ARGS[@]}" \) \
    -exec ln -sfn {} \;

# Symlink individual items inside each special dir
for dir in "${SPECIAL_DIRS[@]}"; do
    if [ -d "${DOTFILES}/${dir}" ]; then
        mkdir -p ~/"${dir}"
        find "${DOTFILES}/${dir}" -maxdepth 1 -mindepth 1 \
            -exec ln -sfn {} ~/"${dir}"/ \;
    fi
done

mkdir -p ~/bin
cd ~/bin || exit 98

find "${DOTFILES}/bin" -exec ln -sfn {} \;

#
# Ensure expected packages available for whichever development environment
# we happen to be in
#
declare -a PACKAGES

if [ -f /.dockerenv ]; then
    PACKAGES=(docker)
elif [[ "$(uname -s)" == "Darwin" ]]; then
    PACKAGES=(macOS claude_mcps)
elif [[ "$(uname -s)" == "Linux" ]]; then
    PACKAGES=(linux)
else
    echo "Unknown environment: $(uname -a)"
    exit 1
fi

for package in "${PACKAGES[@]}"; do
    if [[ -x "${DOTFILES}/install/${package}.sh" ]]; then
        echo "Installing package ${package}"
        "${DOTFILES}/install/${package}.sh"
    fi
done
