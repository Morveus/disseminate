#!/bin/bash

if [[ "$(uname)" == "Linux" ]]; then
    if ! whereis fish > /dev/null; then
        sudo apt update && sudo apt install fish wget curl -y
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    if ! whereis fish > /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install fish git wget curl
    fi
fi

git clone https://github.com/Morveus/disseminate $HOME/.config/fish/disseminate

sleep 3

cp $HOME/.config/fish/disseminate/fish/functions/*.fish $HOME/.config/fish/functions
cp $HOME/.config/fish/disseminate/fish/config.fish $HOME/.config/fish/

echo; echo; "DONE."; echo "NOW type 'fish' then 'disseminate update'"; echo; echo;
