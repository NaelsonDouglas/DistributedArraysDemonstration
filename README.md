# JuliaPlayground

Julia can create it's own "virtual machines" with the command addprcs().
In other database systems if we want to create a cluster we'd need to to call 2 or more physical machines or emulate them with VMware or Docker.
In Julia we can just create these machines with
	* addprocs(NUMBER_OF_MACHINES)
	* addprocs(3) #add 3 virtual machines to the cluster

In order to check how many machines (let's call them process instead of machine) you can use the command nprocs(), which returns the current amout of running process in your workstation.

The process are labeled with numbers, starting from 1.
Since Julia works in the master/slave paradigm, the first process to be created is the master, which is the one that starts with the language terminal call (i.e. the terminal you are using).
After you add another process with addprocs(), the processes 2,3,4,5... are going to be the slave/workers process and the process 1 is the master.

You can check your workers processes with workers()

From the master you can send commands to the slave process with the macro @spawnt, which takes as input the number of the process you want to spawn the command and the command itself. This macro then returns an address pointing in the remote process the return value  of the command call.
	* @spawnat 2 [1:100;] # creates in the process 2 an array of 1,2,3,4,5...97,98,99,100
	* @spawnat 2 sqrt(100) #tells the process 2 to calculate the square root of 100

In order to spawn a command you need to have the running process. As it was said before, you can always use workers() to check if the process is running. If you spawn a command in a process which doesn't exist, you'll get an error.


This repository has some simple functions you can use in arrays created in a remote process.
	*	remote_set(f, ref, indexes = [1,1])
		*	this function gets another function f as input, a reference and an array of indexes, which you can left empty and use the [1,1] defaut value
		*	The function will apply f to all selected indexes of the vector f
		*	a = @spawnat 2 [1:10;] #creates an array 1~10 and stores it's reference in a
		*	fetch(a) #reads the value stored in the reference a
		*	g(x) = 10*x #creates a function g which gets x and returns 10*x
		*	a = remote_set(g,a,[1:10;]) #apply g in all 10 values of a and updates the reference of a
		*	fetch(a) #reads the updated value stored in the reference a

In this example we used a matrix of integers, but we can always use custom data types to store information. The main.jl has a pre-built type named Person, which has the fields name and age. Person("Caio", 24) creates an object of Person with the name Caio and age 24.

You can call a remote object of person with

	*	x = @spawnat 2 Person("Caio",24)
Or
	*	caio = Person("Caio",24)
	*	x = @spawnat 2 caio
and you can check the data with
	*	fetch(x)

If you want to store may objects of the type Person, you can create an array and push them in it with remote_push

	*	array = @spawnat 2 [] #creates an empty array in 2
	*	array = remote_push(array,Person("Caio",24)
	*	array = remote_push(array,Person("Thiago",23)
	*	fetch(array)
	




















