#saves the IP address to the var "master"

master="$( docker exec master-node-0 hostname -i)"

#Send the list of IPs to the master


printf " \n ----------------------------------------------------------------------------------- \n ---> The default password is '123'. You can change it at /src/docker/Dockerfile <--- \n ----------------------------------------------------------------------------------- \n"
cat ~/.ssh/id_rsa.pub | ssh root@$master  "cat >> ~/.ssh/authorized_keys"
source get-ips.sh


scp -q IPs.txt root@$master:IPs.txt

printf " ---> The list with all avaliable cluster IPs was saved to the folder $master_user at the master machine (IP: $master) \n"

printf " ---> You can connect to it anytime with ssh 'root@\$master' \n"
startup_line="$(echo printf  \" \\n ===================================================================== \\n  You are inside the cluster master machine. \\n To exit it just press ctrl+D  \\n To start working on Julia using the cluster machines enter the  command:  \\n \'julia --machinefile IPs.txt\' \\n --It will load all the machines listed on the file and use them as processes \\n ===================================================================== \\n \")"

echo $startup_line | ssh root@$master  "cat >> ~/.profile"

ssh root@$master "echo \$startup_line"
ssh root@$master
clear

printf '\e[1;36m%-6s\e[m' " You are now out of the cluster. If you want to remove all the machines use 'source stop-cluster'"
printf "\n"





