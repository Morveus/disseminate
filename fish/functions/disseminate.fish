function disseminate
    echo "Disseminate 1.0 ~~ https://morve.us" | mlolcat
    switch $argv[1]
        case update
            rm -fR /tmp/disseminate
	    git clone https://github.com/Morveus/disseminate /tmp/disseminate | lolcat
            echo "Fish commands and Disseminate updated" | mlolcat
        case help
            echo "Usage:"
            echo "disseminate update : updates my fish shell and this actual script"
            echo "disseminate help : shows this help"
        case '*'
            echo "Invalid command. Try 'disseminate help' for usage."
    end
end
