function is_unraid
    if test -e /boot/config/go
	return 0
    end

    return 1
end
