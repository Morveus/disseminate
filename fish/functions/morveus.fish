function morveus
    echo "Morveus Helper 1.0 ~~ https://morve.us/dis" | mlolcat

    switch $argv[1]
	case update
	    disseminate update
        case connect
            switch $argv[2]
                case home
                    ssh -t morveus@morve.us ssh morveus@rack1.morve.us
                case vps
                    ssh morveus@morve.us
                case nas
                    ssh -t morveus@morve.us ssh -t morveus@rack1.morve.us ssh root@192.168.1.10
                case '*'
                    echo "Invalid connection. Try 'home', 'vps' or 'nas'."
            end
        case help
            echo "Usage:"
            echo "morveus connect [home|vps|nas] : quick connect to the main entrypoints at home"
            echo "morveus help : shows this help"
        case '*'
            echo "Invalid command. Try 'morveus help' for usage."
    end
end
