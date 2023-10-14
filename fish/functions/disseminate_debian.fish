function disseminate_debian
   if not type -q pip3
        sudo apt install python3-pip
   end   
end
