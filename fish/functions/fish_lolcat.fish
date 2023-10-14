function fish_lolcat
    set colors red green yellow blue magenta cyan

    while read -l line
        for i in (seq (string length $line))
            set color (math (random) % 6 + 1)
            set -l char (string sub -s $i -l 1 -- $line)
            echo -n -e (set_color $colors[$color])$char(normal)
        end
        echo
    end
end
