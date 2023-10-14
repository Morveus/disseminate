if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Add repository then install fish
if ! grep -q "ich777" /boot/config/plugins/un-get/sources.list; then
    echo "https://raw.githubusercontent.com/ich777/slackware/master/slackware64-15.0/slackware64/ ich777" >> /boot/config/plugins/un-get/sources.list
fi

# Install fish
un-get update
un-get install fish

# Change the current shell, make sure it changes on reboot, and activate it
usermod root -s /usr/bin/fish

if ! grep -q "usermod root" /boot/config/go; then
    echo "usermod root -s /usr/bin/fish" >> /boot/config/go
fi

git clone https://github.com/Morveus/disseminate /boot/config/disseminate
cp /boot/config/disseminate/fish/config.fish /root/.config/fish/
cp /boot/config/disseminate/fish/functions/* /root/.config/fish/functions/

if ! grep -q "config.fish" /boot/config/go; then
    echo "cp /boot/config/disseminate/fish/config.fish /root/.config/fish/" >> /boot/config/go
fi

if ! grep -q "fish/functions/" /boot/config/go; then
    echo "cp /boot/config/disseminate/fish/functions/* /root/.config/fish/functions/" >> /boot/config/go
fi


fish
