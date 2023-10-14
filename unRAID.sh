# Install plug-in : https://raw.githubusercontent.com/ich777/un-get/master/un-get.plg

# Add repository then install fish
echo "https://raw.githubusercontent.com/ich777/slackware/master/slackware64-15.0/slackware64/ ich777" >> /boot/config/plugins/un-get/sources.list
un-get update
un-get install fish

# Change the current shell, make sure it changes on reboot, and activate it
usermod root -s /usr/bin/fish
echo "usermod root -s /usr/bin/fish" >> /boot/config/go
fish
