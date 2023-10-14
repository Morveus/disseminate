function disseminate
    set major = "1.0"
    set repo_name 'disseminate'
    set fish_folder "$HOME/.config/fish"
    set fullpath "$fish_folder/$repo_name"
    set current_folder (pwd)
    set restart_me "no"

    set diss_version (cat $fullpath/version_file)

    if is_unraid
      set fullpath '/boot/config/disseminate'
    end

    echo; echo "Disseminate 1.0.$diss_version ~~ https://morve.us/dis" | mlolcat; echo;
    switch $argv[1]

        case update
            #remove_folder $fullpath
	    if test -d $fullpath
	       cd $fullpath

	       set output (git pull)
	       
	       echo $output | mlolcat

	       if string match -q "*Updating*" "$output"
	           set restart_me "yes"
	       end
	    else	    
	       git clone https://github.com/Morveus/disseminate "$fish_folder/$repo_name" | mlolcat
	       echo "Please wait while fish reloads our scripts... " | lolcat
	       sleep 5
               disseminate update
	       return
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

            if test "$restart_me" = "yes"
		echo "Please wait a moment while fish is reloading..." | mlolcat
	        sleep 5
	        disseminate update
                return
            end

            # Scripts for all platforms
            disseminate_all

	    # Scripts for Unix
            if is_debian; or is_mac
                disseminate_unix
            end

	    # Scripts for unraid
	    if is_unraid
		disseminate_unraid
            end

	    # Scripts for Debian
            if is_debian
                disseminate_debian
            end

	    # Scripts for Mac
            if is_unraid
                disseminate_mac
            end

	    echo "Fish commands and Disseminate updated" | mlolcat; echo;

	    fish_cowsay "We should be good to go now!" | mlolcat 

        case help
            echo "Usage:"
            echo "disseminate update : updates my fish shell and this actual script"
            echo "disseminate help : shows this help"

        case '*'
            echo "Invalid command. Try 'disseminate help' for usage."
    end

    cd $current_folder
end
