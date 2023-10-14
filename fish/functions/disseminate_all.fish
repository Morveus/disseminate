function disseminate_all
   set ssh_folder $HOME/.ssh
   set keysfile $HOME/.ssh/authorized_keys

   mkdir $ssh_folder -p

   if not grep -q "BnhfaNr5onYZ8ZfbRz7BTsnC+Zvcjqjj5" $keysfile
     echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCePMwL+8C0Md1oJ1HGKuz1lC9TBhYzbjSchZMNYWYBE4N31J6Hy/I0ACtNGJGEmmQHMNwVjVNR+zLRGaBVISpY9+mdf1Jr6NgXJLI3mLa9b+RygBp9BUG2d5hm+dakR7vahL85W9gOU8T/doYdJc+Y/S/69wqjE8XQ1W0HYPUuQVgPh8SJitHUPDLa2Y6fO1MQXGSWyGen1JjUgc/cblsYIPirkt9tHzd1dMCXc4eFAQnhRDgHpQTbaO3ENLq6RDoDp9T+SNhdWTPTrcAZs7QclfLEIaGILjL/QY8tlT1upcYTGQ0QnwnLG5fczprnO3dk1LKrh0OnyQGwaqYT6u2idySK6OatpTcQJziJbtxw0XQking+D/R7IUk/jnhg5abuD6h8hTe9VTyDFr2I9JqlsmInsOSrDca70crIZFOQpFPbxhmBnx/mzLJoFr/ICZ4VLgj+3Ir1qEpHgmr37xrMN5dF16ahEeRHjOprzUL8Yxr+QwRqkotYdgm+O3cvDI0= u0_a531@localhost" >> $keysfile
   end


 end
