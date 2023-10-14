function disseminate_unraid
   set keysfile $HOME/.ssh/authorized_keys
   set keysfileboot /boot/config/authorized_keys
   set gofile /boot/config/go

   if not type -q lolcat
	pip3 install lolcat
   end

   if test -e $keysfile
	cp $keysfile $keysfileboot
   end

   if ! grep -q "$keysfileboot" $gofile; then
     echo "cp -p $keysfileboot $keysfile" >> /boot/config/go
   fi
      
end
