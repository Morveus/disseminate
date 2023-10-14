function mlolcat
    read -d \n -z input

    if is_unraid
        echo -n $input | fish_lolcat
        return
    end

    if is_debian; or is_mac
        echo -n $input | lolcat
	return 1
    else
        echo -n $input
	return 1
    end
end
