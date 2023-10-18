function cluster_node_deploy
   echo '' > /etc/motd
   set main_ip (ip route get 1 | awk '{print $(NF-2);exit}')
   set last_byte (echo $main_ip | cut -d '.' -f 4)

   echo "IP address is: $main_ip. Make sure it's correctly set on the UDM before going on." | mlolcat

   set hostname_prefix 'rackmount'
   set hostname_suffix ''
   set console_name 'rackmount #'
   set dns_prefix 'rack'
   set node_number (math "$last_byte - 149")
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
   echo "$full_dns" | sudo tee /etc/hostname
   sudo sed -i 's/raspberrypi/full_dns/g' /etc/hosts

   sudo apt install -y open-iscsi lsscsi sg3-utils multipath-tools scsitools cifs-utils nfs-common

   echo "Adding node to the cluster..." | mlolcat
   echo "Please provide the K8S master token" | mlolcat
   echo "(sudo cat /var/lib/rancher/k3s/server/node-token on the server)"
   read -l input
   if test -n "$input"
      set master_token $input
   else
      echo -e "\033[31mTOKEN REQUIRED\033[0m"
      return 1
   end

   echo $master_token
end
