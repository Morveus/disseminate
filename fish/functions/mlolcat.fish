function mlolcat
    read -d \n -z input
    if is_debian
        echo -n $input | lolcat
    else
        echo -n $input
    end
end
