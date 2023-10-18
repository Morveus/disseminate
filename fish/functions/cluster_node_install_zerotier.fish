function cluster_node_install_zerotier
    set zerotier_network (cat /mnt/user/MegaNAS/Cluster/variables/zerotier-network)

   if not test -f "/usr/sbin/zerotier-cli"
       echo "Installing ZeroTier" | mlolcat
       curl -s https://install.zerotier.com | sudo bash
   else
       echo "Zerotier already installed" | mlolcat
   end

   if sudo zerotier-cli listnetworks | grep -q $zerotier_network;
       echo "Already connected to the cluster's ZT network" | mlolcat
   else
       echo "Connecting to the cluster's ZT network..." | mlolcat
       set zt_command "sudo zerotier-cli join $zerotier_network"
       echoo $zt_command | mlolcat
       eval $zt_command
       echo "Done. Don't forget to update the ZT network through the dashboard"
   end
end
