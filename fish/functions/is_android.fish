function is_android
    set output (uname -r)

    if string match -q "*android*" "$output"
    	return 0
    end
    return 1
end
