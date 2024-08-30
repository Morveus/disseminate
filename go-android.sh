apt update
pkg up
pkg up
pkg in clang pkg-config libxml2 libxslt libjpeg-turbo -y
apt install python -y
pip install lolcat pyfiglet
pip install imagemagick wget -y
pkg install cronie termux-services -y

#pip install cython lxml==5.0.0
#pip install wanda -U 

echo "Restart Termux and type 'sv-enable crond' 
sleep 3

git clone https://github.com/Morveus/disseminate $HOME/.config/fish/disseminate

cp $HOME/.config/fish/disseminate/fish/config.fish $HOME/.config/fish/
cp $HOME/.config/fish/disseminate/fish/functions/*.fish $HOME/.config/fish/functions/
