amount=$(docker ps | grep node | wc -l)
docker rm -f master-node-0
for i in `seq 1 $((amount-1))`;
	do
		docker rm -f node-$i
	done

> IPs.txt
