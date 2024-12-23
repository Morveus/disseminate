function morveus
    set major = "1.0"
    set repo_name 'disseminate'
    set fish_folder "$HOME/.config/fish"
    set fullpath "$fish_folder/$repo_name"
    set diss_version (cat $fullpath/version_file)
    pyfiglet "Morveus v$diss_version" | mlolcat

    switch $argv[1]
        case k9s
	    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@plane1.morve.us -t "fish -i -c 'k9s'"
	case update
	    disseminate update
        case connect
            switch $argv[2]
		case lb
		    echo "Connecting to load balancer" | mlolcat
		    ssh -J morveus@morve.us morveus@lb.morve.us
                case home
                    echo "Connecting to rack1" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@rack1.morve.us
                case plane1
                    echo "Connecting to Cluster Control Plane 1" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@plane1.morve.us
                case plane2
                    echo "Connecting to Cluster Control Plane 2" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@plane2.morve.us
                case plane3
                    echo "Connecting to Cluster Control Plane 3" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@plane3.morve.us
                case vps
                    echo "Connecting to morve.us" | mlolcat
                    ssh morveus@morve.us
                case vps-ionos
                    echo "Connecting to vps-ionos.morve.us" | mlolcat
                    ssh morveus@vps-ionos.morve.us
                case nas
                    echo "Connecting to unRAID" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us root@192.168.1.10
                case ai
                    echo "Connecting to the AI rack machine" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@rack2.morve.us
                case streamer
                    echo "Connecting to the Volumio streamer" | mlolcat
                    sshpass -p 'volumio' ssh volumio@streamer.morve.us -o StrictHostKeyChecking=no
                case mereau-backup
		    echo "Connecting to Mereau Offsite Backup" | mlolcat
		    ssh root@mereau.backup.morveus.com
                case gate
		    echo "Connecting to Gate controller" | mlolcat
		    ssh -J morveus@morve.us,morveus@lb.morve.us morveus@gate.morve.us
                case '*'
                    echo "Invalid connection. Try 'home', 'vps', 'vps-ionos', or 'nas'."
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
             end

        case 'photos' 'photo'
            switch $argv[2]
                case session
                   echo "Setting photo session to '$argv[3]'" | mlolcat
                   set sessionname (string escape --style=url "$argv[3]")
                   set token (cat $HOME/PHOTOS_SEMAPHORE_TOKEN)
                   
                   curl "https://semaphore.photos.morve.us/?token=$token&semaphore_session_name=$sessionname"
                   
		   echo; echo "Session is now '$argv[3]'." | mlolcat
             end

        case archive
             echo "Archiving $argv[2]..." | mlolcat
             tar -cvzf "$argv[2].tar.gz" "$argv[2]"
             echo "Deleting source folder..." | mlolcat
             rm "$argv[2]" -fR

	case help
	    echo "Morveus Helper ~~ https://morve.us/dis" | mlolcat
	    echo "Usage:" | mlolcat
	    echo "  morveus connect [option]" | mlolcat
	    echo "      - Quick connect to the main entrypoints at home." | mlolcat
	    echo "          home: Connects to rack1" | mlolcat
	    echo "          ai: Connects to AI machine" | mlolcat
	    echo "          vps: Connects to morve.us" | mlolcat
	    echo "          nas: Connects to unRAID" | mlolcat
	    echo "          gate: Connects to Gate controller" | mlolcat
	    echo "          mereau-backup: Connects to Mereau Offsite Backup (Internal Network)" | mlolcat
	    echo "          streamer: Connects to the Volumio streamer" | mlolcat
	    echo;

	    echo "  morveus kubernetes rollout-everything" | mlolcat
	    echo "      - Rollouts all K8S deployments on the local cluster." | mlolcat
	    echo;

            echo "  morveus photos session [name]" | mlolcat
            echo "      - Sets the current photo session to 'name' ; can be emptied to finish the session" | mlolcat
            echo;

	    echo "  morveus help" | mlolcat
	    echo "      - Shows this help message." | mlolcat
	    echo; 

	    echo "Please visit https://morve.us/dis for more information." | mlolcat
        case '*'
            echo "Invalid command. Try 'morveus help' for usage."
    end
end

complete -c morveus -a "update connect kubernetes help"
complete -c morveus -n "__fish_seen_subcommand_from connect" -a "home ai vps nas streamer mereau-backup"
complete -c morveus -n "__fish_seen_subcommand_from kubernetes" -a "rollout-everything"
