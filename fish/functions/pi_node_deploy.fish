function pi_node_deploy
   echo "ADDING A NEW NODE TO THE CLUSTER" | mlolcat

   set main_ip (ip route get 1 | awk '{print $(NF-2);exit}')
   echo "IP address is: main_ip. Make sure it's correctly set on the UDM before going on." | mlolcat

   set last_byte (echo $main_ip | cut -d '.' -f 4)
   set node_number (math "$last_byte - 100")

   echo "Computed node number is '$node_number'. Press ENTER if ok, or enter the new number: " | mlolcat

   read -l input
   if test -n "$input"
       set node_number $input
   end

   set node_name "pi-$node_number"
   set fqdn "pi$node_number.cluster.morve.us"
   
   echo "What will be the node name? (default: $node_name)" | mlolcat
   read -l input
   if test -n "$input"
       set node_name $input
   end
   
   echo "And its DNS name? (default: $fqdn)" | mlolcat
   read -l input
   if test -n "$input"
       set fqdn $input
   end
   
   echo "Node number: $node_number"
   echo "Node name: $node_name"
   echo "FQDN: $fqdn"

   set new_hostname "pi-node-$node_number"
   disseminate set name "Pi Cluster Node $node_number"
   sudo hostnamectl set-hostname "$new_hostname"
   sudo echo "$new_hostname" > /etc/hostname

   sudo apt install -y open-iscsi lsscsi sg3-utils multipath-tools scsitools cifs-utils nfs-common

   echo "Adding node to the cluster..." | mlolcat
   echo "Please provide the K8S master token:" | mlolcat
   read -l input
   if test -n "$input"
      set master_token $input
   else
      echo -e "\033[31mTOKEN REQUIRED\033[0m"
      exit
   end

   echo $master_token
end
