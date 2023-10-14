function disseminate
    echo "Disseminate 1.0 ~~ https://morve.us" | mlolcat
    switch $argv[1]
        case update
            remove_folder "~./config/fish/disseminate/"
	    git clone https://github.com/Morveus/disseminate ~/.config/fish/disseminate | lolcat
            echo "Fish commands and Disseminate updated" | mlolcat
        case help
            echo "Usage:"
            echo "disseminate update : updates my fish shell and this actual script"
            echo "disseminate help : shows this help"
        case '*'
            echo "Invalid command. Try 'disseminate help' for usage."
    end
end
