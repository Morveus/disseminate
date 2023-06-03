# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Fish
brew install fish

# Add fish as default 
echo "/home/linuxbrew/.linuxbrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /home/linuxbrew/.linuxbrew/bin/fish

# Install Starship 
brew install starship

# Deploy my SSH public key 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/BnhfaNr5onYZ8ZfbRz7BTsnC+Zvcjqjj5/QaJJUMzFQE+Urb1TXGKuaAG/IYt/pWIld5MGJt0T53w+AP7McrF9ROp1vwLYMKS058fXfOm8bab1DShfOBDNtnF3n/ojLN7CVXGDXgblxbxR+2svhzztldfXlm5kaj4g/UheZHkvOuLNWpyMgHUDxaL/kQXUK2dOqf5sarpFR1qgLpnLAXnbow76kfqJNm0YCkHsnLdpLoRX5RtD8POpEa+5NM7D9rwYby4dEMhMh2V26zJdBUcbGsMoHUjzQBGhvKft0XpGOBQO/e+X/UUq+//aLmVOhIZK1lqybynK+S0gsU/RYL
