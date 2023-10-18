function disseminate_pi_node

end

function pi_node_deploy
   echo "Enter node number:"
   read node_number
   set node_name "pi-$node_number"
   set fqdn "pi$node_number.cluster.morve.us"
   
   echo "Node name (default: $node_name):"
   read -l input
   if test -n "$input"
       set node_name $input
   end
   
   echo "FQDN (default: $fqdn):"
   read -l input
   if test -n "$input"
       set fqdn $input
   end
   
   echo "Node number: $node_number"
   echo "Node name: $node_name"
   echo "FQDN: $fqdn"
end

function is_raspberry
   if test -f /proc/device-tree/model
       set model (cat /proc/device-tree/model)
       if string match -r 'Raspberry Pi' $model
           return 0
       else
           return 1
       end
   else
       return 1
   end
end
