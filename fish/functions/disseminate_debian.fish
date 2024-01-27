function disseminate_debian
   if not type -q pip3
        sudo apt install python3-pip -y
   end   

   if not type -q cargo
        sudo apt install cargo -y
   end

   if not type -q dusage
        cargo install dusage -y
   end   

end
