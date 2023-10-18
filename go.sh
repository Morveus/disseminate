#!/bin/bash

if [[ "$(uname)" == "Linux" ]]; then
    sudo apt update && sudo apt install fish wget git python3 python3-pip python3-pyfiglet lolcat sshpass -y
    chsh -s /usr/bin/fish
elif [[ "$(uname)" == "Darwin" ]]; then
    if ! whereis fish > /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install fish git wget curl lolcat sshpass
	echo "/home/linuxbrew/.linuxbrew/bin/fish" | sudo tee -a /etc/shells
	chsh -s /home/linuxbrew/.linuxbrew/bin/fish
    fi
fi

git clone https://github.com/Morveus/disseminate $HOME/.config/fish/disseminate

sleep 3

cp $HOME/.config/fish/disseminate/fish/functions/*.fish $HOME/.config/fish/functions
cp $HOME/.config/fish/disseminate/fish/config.fish $HOME/.config/fish/

echo; echo "DONE."; echo "NOW type 'fish' then 'disseminate update'"; echo; echo;
