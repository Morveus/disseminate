function is_debian
    if test -f /etc/os-release
        set os_info (cat /etc/os-release)
        if string match -r "debian" $os_info > /dev/null
            return 0
        end
    end
    return 1
end
