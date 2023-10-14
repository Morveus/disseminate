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
mkdir ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/BnhfaNr5onYZ8ZfbRz7BTsnC+Zvcjqjj5/QaJJUMzFQE+Urb1TXGKuaAG/IYt/pWIld5MGJt0T53w+AP7McrF9ROp1vwLYMKS058fXfOm8bab1DShfOBDNtnF3n/ojLN7CVXGDXgblxbxR+2svhzztldfXlm5kaj4g/UheZHkvOuLNWpyMgHUDxaL/kQXUK2dOqf5sarpFR1qgLpnLAXnbow76kfqJNm0YCkHsnLdpLoRX5RtD8POpEa+5NM7D9rwYby4dEMhMh2V26zJdBUcbGsMoHUjzQBGhvKft0XpGOBQO/e+X/UUq+//aLmVOhIZK1lqybynK+S0gsU/RYL" >> ~/.ssh/authorized_keys

# Aliases
alias kubernetes-full-rollout=kubectl get deployments --all-namespaces -o json | jq -c -r '.items[] | "\(.metadata.namespace) \(.metadata.name)"' | while read -r ns deployment; do kubectl rollout restart deployment "$deployment" -n "$ns"; done 

# Various packages 
sudo apt install lolcat -f 

# Run within fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/spark.fish

# Fish config 
echo "alias clear='echo -en \"\\x1b[2J\\x1b[1;1H\" ; echo; echo; seq 1 (tput cols) | sort -R | spark | lolcat; echo; echo'" >> ~/.config/fish/config.fish 
echo "alias rainbow-spark='seq 1 (tput cols) | sort -R | spark | lolcat'" >> ~/.config/fish/config.fish
echo "alias rainbow-line='string repeat -n (tput cols) (echo -e \"\\u2588\") | lolcat'" >> ~/.config/fish/config.fish
