function morveus
    echo "Morveus Helper 1.0 ~~ https://morve.us/dis" | mlolcat

    switch $argv[1]
	case update
	    disseminate update
        case connect
            switch $argv[2]
                case home
                    echo "Connecting to rack1" | mlolcat
                    ssh -t morveus@morve.us ssh morveus@rack1.morve.us
                case vps
                    echo "Connecting to morve.us" | mlolcat
                    ssh morveus@morve.us
                case nas
                    echo "Connecting to unRAID" | mlolcat
                    ssh -t morveus@morve.us ssh -t morveus@rack1.morve.us ssh root@192.168.1.10
                case streamer
                    echo "Connecting to the Volumio streamer" | mlolcat
                    sshpass -p 'volumio' ssh volumio@streamer.morve.us
                case '*'
                    echo "Invalid connection. Try 'home', 'vps' or 'nas'."
            end
        case kubernetes
            switch $argv[2]
                case rollout-everything
                    echo "Rolling out all deployments on the local k8s cluster" | mlolcat
                    echo "Are you sure? [y/N]" | mlolcat
                    read -l response
                    switch $response
                        case Y y
                           _morveus-kubernetes-full-rollout 
                        case '*'
                           echo "Operation cancelled." | mlolcat
             end
        case help
            echo "Usage:"
            echo "morveus connect [home|vps|nas] : quick connect to the main entrypoints at home"
            echo "morveus help : shows this help"
        case '*'
            echo "Invalid command. Try 'morveus help' for usage."
    end
end

complete -c morveus -a "update connect kubernetes help"
complete -c morveus -n "__fish_seen_subcommand_from connect" -a "home vps nas streamer"
complete -c morveus -n "__fish_seen_subcommand_from kubernetes" -a "rollout-everything"

