
addprocs(3) #adciona máquinas no sistema. Como não temos máquinas físicas, vamos adcionar processos locais. Faríamos addprocs([ssh@id]) caso tivéssemos máquinas


@everywhere type Person #define uma nova struct. O @everywhere diz para definir em todas as máquinas/processos
	name
	age
end


#função que recebe uma função f, uma referência remota (tipo um ponteiro de rede em uma máquina remota) e aplica f em todos os indexes da variável. Indexes tem como padrão [1,1], caso você não especifique (i.e. #faça a chamada só com dois parâmetros), esse será o valor usado 
function remote_set(f, ref, indexes = [1,1]) 
	localy = fetch(ref)
	for (i in indexes)
		localy[i] = f(localy[i])
	end
	@spawnat ref.where localy	
end


#Recebe uma referência remota e empurra value no fim do array dentro da referência
function remote_push(ref,value)
	localy = fetch(ref)
	localy = vcat(localy,value)
	@spawnat ref.where localy	
end


#Aplica a função f em todas as células do vetor armazenado em ref. É a mesma coisa que remote_set. Fiz a set para ter um equivalente a A[1] = 10 distribuido e a process para processar toda a matriz, embora o código seja o mesmo.
function remote_process(f, ref, indexes = [1,1])
	remote_set(f,ref,indexes=indexes)
end
	




