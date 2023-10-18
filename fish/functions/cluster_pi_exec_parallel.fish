function cluster_pi_exec_parallel
  set ssh_command $argv[1]
  for i in (seq 101 114)
      ssh -o StrictHostKeyChecking=no morveus@10.10.10.$i $ssh_command &
  end
end
