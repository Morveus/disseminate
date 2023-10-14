function drugs
    set -l drugs "DRUGS "
    set -l drugs_length (string length $drugs)
    set -l count (math "$COLUMNS / $drugs_length")
    set content ''

    for j in (seq $LINES)
        for i in (seq $count)
            set content "$content$drugs"
        end
        set content "$content\n"
    end

    printf $content | mlolcat
end

