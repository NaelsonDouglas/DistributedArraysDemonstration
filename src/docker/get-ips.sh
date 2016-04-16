> IPs.txt
amount=$(docker ps | grep node | wc -l)
user="root"

	if [ "$amount" > 1 ]; then
		for i in `seq 1 $((amount-1))`;
			do
				ip="$(docker exec node-$i hostname -i)"			
				echo $user"@"$ip >> IPs.txt
			done
	echo IP\'s saved to IPs.txt
	cat IPs.txt
else
	echo  There are no machines
	fi
	echo 

	echo

master="$( docker exec master-node-0 hostname -i)"





