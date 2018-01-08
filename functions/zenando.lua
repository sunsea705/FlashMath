--[[

Essa função recebe como parâmetro um número específico 
de linhas e colunas junto com uma faixa de números
e gera uma matriz contendo expressões
matemáticas aleatórias baseadas nessa faixa e uma matriz
com uma quantidade específica de expressões.

A funçao após isso escolhe uma posição aleatória 
da matriz que foi gerada, e então cria uma expressão aleatória cujo
resultado é 10 e substitui na expressão que havia anteriormente. 

]]--
math.randomseed(os.time())

require "functions/operacionando"
require "functions/numerando"

function zenando(int1, int2, int3) -- sim, temos uma matriz de tabela. A que ponto cheguei
	-- PREENCHENDO OS RETÂNGULOS COM EXPRESSÕES
	expressions = {}
	for i = 1, 5 do
		expressions[i] = {}
		for j = 1, 4 do 
			n1, n2, ope, result = operacionando(int1, int2, int3)
			expressions[i][j] = {printi = n1 .. numerando(ope) .. paranteseando(n2), result = result} 
		end
	end
	
	-- REMOVENDO QUALQUER RESULTADO REPETIDO DE 10
	for i = 1, 5 do
		for j = 1, 4 do
			if expressions[i][j].result == 10 then 
				n1, n2, ope, result = operacionando(int1, int2, int3)
				while result == 10 do
					n1, n2, ope, result = operacionando(int1, int2, int3)
				end
				expressions[i][j] = {printi = n1 .. numerando(ope) .. paranteseando(n2), result = result} 
			end
		end
	end
	
	-- E FINALMENTE, FORÇA UMA EXPRESSÃO A SEMPRE TER O RESULTADO 10 E GUARDA ELA EM ALGUM LUGAR ALEATÓRIO DA MATRIZ
	buffer = math.random(1, 5); linha = math.random(1, 5)
	buffer = math.random(1, 4); coluna = math.random(1, 4)
	n1, n2, ope, result = operacionando(int1, int2, int3)
	while result ~= 10 do
		n1, n2, ope, result = operacionando(int1, int2, int3)
	end
	expressions[linha][coluna] = {printi = n1 .. numerando(ope) .. paranteseando(n2), result = result} 
	
	return expressions

end