function disseminate_all
   # SSH Keys
   set ssh_folder $HOME/.ssh
   set keysfile $HOME/.ssh/authorized_keys

   mkdir $ssh_folder -p

   if not grep -q "AAAAB3NzaC1yc2EAAAADAQABAAABgQCePMw" $keysfile
     echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCePMwL+8C0Md1oJ1HGKuz1lC9TBhYzbjSchZMNYWYBE4N31J6Hy/I0ACtNGJGEmmQHMNwVjVNR+zLRGaBVISpY9+mdf1Jr6NgXJLI3mLa9b+RygBp9BUG2d5hm+dakR7vahL85W9gOU8T/doYdJc+Y/S/69wqjE8XQ1W0HYPUuQVgPh8SJitHUPDLa2Y6fO1MQXGSWyGen1JjUgc/cblsYIPirkt9tHzd1dMCXc4eFAQnhRDgHpQTbaO3ENLq6RDoDp9T+SNhdWTPTrcAZs7QclfLEIaGILjL/QY8tlT1upcYTGQ0QnwnLG5fczprnO3dk1LKrh0OnyQGwaqYT6u2idySK6OatpTcQJziJbtxw0XQking+D/R7IUk/jnhg5abuD6h8hTe9VTyDFr2I9JqlsmInsOSrDca70crIZFOQpFPbxhmBnx/mzLJoFr/ICZ4VLgj+3Ir1qEpHgmr37xrMN5dF16ahEeRHjOprzUL8Yxr+QwRqkotYdgm+O3cvDI0= u0_a531@localhost" >> $keysfile
   end

   if not grep -q "AAAAB3NzaC1yc2EAAAADAQABAAABgQDBp4ye1qpGfC" $keysfile
     echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBp4ye1qpGfCX4kR6IlHbCcVX5SSrtfjcvaqZVd1lpLys7P04HOF/EQCjdmPdX9YA+f3oUbcHsypLGrdeCSwC85Llj8oHcO+8dxLsyp8nJ4xJ8tW7MsO/LqIi9H8qbyY4B8fk1tqwhcOvHzsoAhH4wezSaTbeg+/uNsGP2NhQfv2Lh/Ex+GkQKbTmFPxOVZAJ3HwOWdzph+dlQSkDcCSddpj5NpPrAKZqSjJAw6qhE8D4PaxFn6EICsdQ8EpewMsANXQPbOrG5ZiuxbQQj8w+tPHZDOgmWpWa4S/GBlcBXjmllcTnnb++Z5TJ1KpJo87D9DtPCccPhsPe2t/dDRbV05Hsw5TW5PEl6TmaAHPBqhq88fFTA3acnXuVQ82Q4aFJFwQVHAhbO89FUOFXRs+K//4mYPShiX7FSXgcP45ucUbugTJ8f1DTzkfRI1gBSF4BqbafoaZTW1MGL40ybz7RudQlSg8IouTL5Y9Wc72fxDx0tlLL4YcC14A1BIl+x/s8= morveus@morveus-home" >> $keysfile
   end

   # pyfiglet
   if not type -q pyfiglet
        if type -q apt
           sudo apt install python3-pyfiglet
        else
           pip3 install pyfiglet
        end
   end


 end
