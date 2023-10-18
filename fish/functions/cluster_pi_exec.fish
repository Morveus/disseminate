function cluster_pi_exec --argument ssh_command
  for i in (seq 101 114)
      ssh -o StrictHostKeyChecking=no morveus@10.10.10.$i $ssh_command
  end
end
