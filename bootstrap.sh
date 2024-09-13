#!/bin/bash
set -euo pipefail

FILES=(
    "keymap.json"
    "settings.json"
)
THEME="aetheme.json"

get_conf_folder() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "$HOME/.config/zed/"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "$HOME/.config/zed/"
    elif [[ "$OSTYPE" == "win32" ]]; then
        :
    fi
}

link_file() {
    echo "  Linking $1"
    ln -sf "$current_folder/$1"
}

main() {
    current_folder=$(pwd)
    conf_folder=$(get_conf_folder)

    if [[ "$conf_folder" == "" ]]; then
        echo "OS $OSTYPE not supported"
        return
    fi

    cd "$conf_folder"
    echo "Linking files to: $conf_folder"

    for file in "${FILES[@]}"; do
        link_file $file
    done

    cd themes/
    link_file $THEME

    cd "$current_folder"
    echo "Success!"
}

main
