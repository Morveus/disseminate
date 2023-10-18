function cluster_node_deploy
   set master_server 'rack1.cluster.morve.us'
   set token_location '/mnt/user/MegaNAS/Cluster/variables/node-token'

   echo "" | sudo tee /etc/motd > /dev/null

   if type -q k3s
      echo -e "\033[31mk3s is already installed!\033[0m"
      echo -e "\033[31mPlease run /usr/local/bin/k3s-agent-uninstall.sh to uninstall it from an agent\033[0m"
      echo -e "\033[31mor /usr/local/bin/k3s-uninstall.sh to uninstall it from a master.\033[0m"
      return 1
   else
      echo "k3s is not installed. We can proceed." | mlolcat
   end

   set main_ip (ip route get 1 | awk '{print $(NF-2);exit}')
   set last_byte (echo $main_ip | cut -d '.' -f 4)

   echo "IP address is: $main_ip. Make sure it's correctly set on the UDM before going on." | mlolcat

   set hostname_prefix 'rackmount'
   set hostname_suffix ''
   set console_name 'rackmount #'
   set dns_prefix 'rack'
   set node_number (math "$last_byte - 149")
   set username (whoami)
   if is_raspberry
      set hostname_prefix 'pi'
      set hostname_suffix '-node-'
      set dns_prefix 'pi'
      set console_name 'Pi Cluster Node'
      set node_number (math "$last_byte - 100")
   end

   echo "ADDING A NEW NODE TO THE CLUSTER" | mlolcat

   echo "Computed node number is '$node_number'. Press ENTER if ok, or enter the new number: " | mlolcat

   read -l input
   if test -n "$input"
       set node_number $input
   end

   set full_dns "$dns_prefix$node_number"
   set local_name "$hostname_prefix$hostname_suffix$node_number"
   set console_name "$console_name $node_number"
   
   echo "Machine: $node_number" | mlolcat
   echo "Local hostname: $local_name" | mlolcat
   echo "DNS Name: $full_dns" | mlolcat
   echo "Console name: $console_name" | mlolcat

   disseminate set name "$console_name"

   sudo hostnamectl set-hostname "$full_dns"
   echo "$full_dns" | sudo tee /etc/hostname > /dev/null
   sudo sed -i 's/raspberrypi/full_dns/g' /etc/hosts

   sudo apt install -y open-iscsi lsscsi sg3-utils multipath-tools scsitools cifs-utils nfs-common


   echo "Creating mountpoints..." | mlolcat
   sudo mkdir -p /mnt/user/MegaNAS
   sudo mkdir -p /mnt/iscsi_k8s

   echo "Connecting to the various NAS servers..." | mlolcat
   set fstab_line "192.168.1.10:/mnt/user/MegaNAS /mnt/user/MegaNAS nfs rw,soft,timeo=100 0 0"
   
   if not grep -q "MegaNAS" /etc/fstab
       echo $fstab_line | sudo tee -a /etc/fstab > /dev/null
       echo "Added MegaNAS to /etc/fstab" | mlolcat
   else
       echo "MegaNAS already in /etc/fstab" | mlolcat
   end

   set fstab_line "//192.168.1.20/k8s /mnt/iscsi_k8s cifs username=cluster,password=cluster123456!,uid=$username,gid=$username,iocharset=utf8 0 0"
   
   if not grep -q "iscsi_k8s" /etc/fstab
       echo $fstab_line | sudo tee -a /etc/fstab > /dev/null
       echo "Added FlashNAS to /etc/fstab" | mlolcat
   else
       echo "FlashNAS already in /etc/fstab" | mlolcat
   end

   echo "systemctl daemon-reload..." | mlolcat
   sudo systemctl daemon-reload
   echo "Mounting..." | mlolcat
   sudo mount -a

   echo "Adding node to the cluster..." | mlolcat
   
   if test -f "/mnt/user/MegaNAS/Cluster/variables/token"; then
       echo "FOUND THE TOKEN in $token_location" | mlolcat
       echo "DO NOT FORGET TO REMOVE THIS FILE ONCE YOU'RE DONE" | mlolcat
       set master_token (cat $token_location)
   else
       echo "Please provide the K8S master token" | mlolcat
       echo "(sudo cat /var/lib/rancher/k3s/server/node-token on the server)"
       read -l input
       if test -n "$input"
           set master_token $input
       else
           echo -e "\033[31mTOKEN REQUIRED\033[0m"
           return 1
       end
   fi
   
   echo "Token: $master_token" | mlolcat; echo;
   
   echo "Running: curl -sfL https://get.k3s.io | K3S_URL=https://$master_server:6443 K3S_TOKEN=\"$master_token\" sh -"
end
