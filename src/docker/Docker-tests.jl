#    Testing the performance of parallel Julia

This document is intended to show the performance of simple Docker cluster running some basic parallel Julia functions. In order to achieve this we will:
* Run some commands on a two machines network an record the execution time with the julia macro @time.
* Run the same commands on a Docker cluster. The commands will be executed from on of the machines via ssh.

## Creating a new process


* Single-Machine environment

We could do ```@time addprocs(2)``` to add 2 process, but instead let's do  ```@time addprocs(1)``` twice to check the individual time for each addition.

    *   We add two process because if we add only one, Julia will use the first as master and the other as worker. We need 2 workers for the tests.
    *   Use ```workers()`` `to check the current workers.

* Two-machines environment
```julia
@time addprocs(1) #To add a worker at the master machine
@time addprocs({"usr-machine2@machine2-IP"}) # Worker 2 at machine2
```
* Docker
```julia
@time addprocs(1) #worker 1 at the master containner
@time addprocs({"usr-containner2@container2-IP"}) #worker 2 at the second containner
```
   * Results (for the remote addprocs):
       * Single: 1.753589606 seconds (for ```addprocs(1)```)
       * Two-machines : 3.282241402 seconds
       * Docker: 1.969255395 seconds
    
       
* Now let's create a darray with the length 10000 for each environment.
    *   For that we user ```@time d_array = dones(100)``` for every case
       * Results:
       * Single:  1.041953158 seconds
       * Two-machines : 0.056110161 seconds
       * Docker: 0.03946407 seconds
   *    We can use d_array.pmap anytime to check the distribution of the data across the machines.
   
   
   * Now let's do some operations on the darray and check the time it takes.
        *   ```@time sum(d_array)``` to sum all the elements inside d_array and get the operation time.
        *   Results:
        *   Single: 0.02136757 seconds
        *   Two-machines: 2.047984934 seconds
        *   Docker: 0.020951201 seconds


