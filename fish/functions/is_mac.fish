function is_mac
    if test (uname) = "Darwin"
	return 0
    end

    return 1
end

