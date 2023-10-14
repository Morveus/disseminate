function disseminate
    set major = "1.0"
    set diss_version (cat version_file)
    set repo_name 'disseminate'
    set fish_folder '~/.config/fish'
    set fullpath "$fish_folder/$repo_name"
    set current_folder (pwd)

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


            set commitcount (git rev-list --all --count)
            echo "$commitcount" > version_file
	    set diss_version (cat version_file)
            echo "Version is 1.0.$diss_version" | mlolcat

	    echo "Fish commands and Disseminate updated" | mlolcat; echo;

        case help
            echo "Usage:"
            echo "disseminate update : updates my fish shell and this actual script"
            echo "disseminate help : shows this help"

        case '*'
            echo "Invalid command. Try 'disseminate help' for usage."
    end

    cd $current_folder
end
