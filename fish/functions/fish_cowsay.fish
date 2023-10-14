function fish_cowsay

    if type -q cowsay
	for arg in $argv
	  cowsay "$arg"
	end
	return
    end

    set line "+----------------------------------------+"
    echo $line
    for arg in $argv
        echo "| $arg |"
    end
    echo $line
    echo " \\   ^__^"
    echo "  \\  (oo)\\_______"
    echo "     (__)\\       )\\/\\"
    echo "         ||----w |"
    echo "         ||     ||"
end
