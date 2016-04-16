clear
source ascart.sh
> IPs.txt
master_user="/root"

clear


printf "\n \n-->If you already have a running cluster the script may not work properly. To fix it you must stop your old cluster first. Do it by using \'source stop-cluster.sh\'\n 
-->Sometimes a machine keeps running in underground mode and you can't even see it with \'docker ps\'. In this case you should remove it manualy with \'docker rm -f machines\'.\n Eg: \'docker rm -f master-node-0 node-1 node-2 node-3 node-4\' \n \n'"
read -p "Press [Enter] to continue"
echo Enter the amount of machines you want to use:
read amount
echo
docker images | grep -Eo '^[^ ]+' #http://stackoverflow.com/questions/15434728/how-to-display-the-first-word-of-each-line-in-my-file-using-the-linux-commands
echo
echo Select the image used on the machines
read name
user="root"
	if [ "$amount" = 1 ]; then		
		docker run -i -d -P --name master-node-0 $name
	else
		if [ "$amount" > 1 ]; then
			docker run -i -d -P --name master-node-0 $name
			for i in `seq 1 $((amount-1))`;
			do
				docker run -i -d -P --name node-$i --link master-node-0 $name				
			done
		fi
    fi
source link-nodes.sh

