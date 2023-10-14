function disseminate
    set major = "1.0"
    set repo_name 'disseminate'
    set fish_folder "$HOME/.config/fish"
    set fullpath "$fish_folder/$repo_name"
    set current_folder (pwd)

    set diss_version (cat $fullpath/version_file)

    echo; echo "Disseminate 1.0.$diss_version ~~ https://morve.us/dis" | mlolcat; echo;
    switch $argv[1]

        case update
            #remove_folder $fullpath
	    if test -d $fullpath
	       cd $fullpath
               git pull | mlolcat
	    else	    
	       git clone https://github.com/Morveus/disseminate "$fish_folder/$repo_name" | mlolcat
  	    end

	    cd $fullpath

	    cp fish/functions/*.fish "$fish_folder/functions/"
            cp fish/config.fish "$fish_folder/"


            set commitcount (git rev-list --all --count)
            echo "$commitcount" > $fullpath/version_file
	    set diss_version (cat $fullpath/version_file)
            echo "Version is 1.0.$diss_version" | mlolcat

	    echo "Sourcing configuration file and functions..." | mlolcat

	    source $fish_folder/config.fish
	    source $fish_folder/functions/*

	    # Scripts for unraid
	    if is_unraid
		disseminate_unraid
            end

	    echo "Fish commands and Disseminate updated" | mlolcat; echo;

	    fish_cowsay "THANKS" | mlolcat	    

        case help
            echo "Usage:"
            echo "disseminate update : updates my fish shell and this actual script"
            echo "disseminate help : shows this help"

        case '*'
            echo "Invalid command. Try 'disseminate help' for usage."
    end

    cd $current_folder
end
