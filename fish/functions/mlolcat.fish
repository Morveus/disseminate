function mlolcat
    read -d \n -z input

    if is_unraid
        echo -n $input | lolcat # yeah I know
    else
       if is_debian; or is_mac
           echo -n $input | lolcat
       else
           echo -n $input
       end
    end
end
