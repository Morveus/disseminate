# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Fish
brew install fish

# Add fish as default 
echo "/home/linuxbrew/.linuxbrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /home/linuxbrew/.linuxbrew/bin/fish

# Install Starship 
brew install starship
