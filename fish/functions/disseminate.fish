function disseminate
    echo "Disseminate 1.0 ~~ https://morve.us" | mlolcat
    switch $argv[1]
        case update
            curl -sL https://raw.githubusercontent.com/Morveus/disseminate/main/fish/config.fish
            echo "Fish commands and Disseminate updated" | mlolcat
        case help
            echo "Usage:"
            echo "disseminate update : updates my fish shell and this actual script"
            echo "disseminate help : shows this help"
        case '*'
            echo "Invalid command. Try 'disseminate help' for usage."
    end
end
