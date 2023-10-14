function mlolcat
   read -d \n -z input

   if is_debian; or is_mac; or is_android; or is_unraid
      echo -n $input | lolcat
   else
      echo -n $input
   end
end
