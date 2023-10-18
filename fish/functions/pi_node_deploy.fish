function pi_node_deploy
   echo "ADDING A NEW NODE TO THE CLUSTER" | mlolcat
   echo "Please enter the node number:" | mlolcat
   read node_number
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
end
