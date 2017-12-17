--[[
Essa função é responsável por gerar dois números aleatórios 
através de uma faixa especificada e um operador também através
de uma faixa especificada, e então além de retornar esses três
números também retorna o valor da expressao, baseada nesses três números.
Essa função recebe como parâmetro justamente os intervalos a serem
gerados os números. Tais intervalos são definidos pelo nível atual
do jogo.

]]--

math.randomseed(os.time())

function operacionando(in1, in2, in3, just)
	buffer = math.random(in1, in2); n1 = math.random(in1, in2)
	buffer = math.random(in1, in2); n2 = math.random(in1, in2)
	
	-- Se just for 4, isso força a função a sempre gerar uma expressão cujo operador é o do divisão
	if just == 4 then -- isso é o controle de quando a divisão gerada for inexata, então a função
		ope = 4 -- sempre será uma divisão até que seja gerado uma divisão exata
	else
		buffer = math.random(1, in3); ope = math.random(1, in3)
	end

	if ope == 1 then
		expressao = n1 + n2
	elseif ope == 2 then
		expressao = n1 - n2
	elseif ope == 3 then
		expressao = n1 * n2
	elseif ope == 4 then
		if n1 % n2 ~= 0 or n2 == 0 then
			operacionando(in1, in2, in3, 4) -- a função irá se chamar, passando 4 como just e então gerará uma divisão exata SEMPRE
		else
			expressao = n1 / n2
		end
	end
	return n1, n2, ope, expressao
end