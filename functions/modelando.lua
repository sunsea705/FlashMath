--[[

Essa função tem como objetivo gerar um valor lógico
entre o resultado de duas expressões que foram geradas
aleatoriamente. Tal valor lógico também é gerado aleatoriamente,
sendo variado entre (==, <=, <, >= e >). Tal função retorna
uma string formatada correspondente ao símbolo lógico
e o valor lógico propriamente dito da comparação entre dois valores.

Exemplo:
Primeiramente, chama-se duas vezes a função operacionando() para que se
gere dois pares de expressões aleatórias:

2 + 7 = 9 e 1 - 8 = -7

Com tais resultados em mãos (9 e -7), chamamos a função modelando passando
esses resultados como parâmetro. Agora, a função irá gerar uma comparação
lógica, aleatória, entre esses dois resultados. Por exemplo, se o modelo gerado for
2, ele vai fazer a verificação:
	logical = (9 <= -7)
Como 9 <= -7 é falso, logo, logical passa a ser false. O usuário deve justamente saber se
o resultado da expressão é true ou false, simplesmente.
Depois disso ele retorna a string formatada "<=" para que ela, junto com os dois pares
de expressões, possam ser exibidas. No programa então, para a contagem de pontos, simplesmente
é feita uma comparação entre o que usuário digitou e o resultado lógico da expressão que foi gerada.

]]--

require "functions/stringeando"
math.randomseed(os.time())

function modelando(leftResult, rightResult)

	buffer = math.random(1, 5); model = math.random(1, 5) -- escolhendo o número do modelo aleatoriamente

	if model == 1 then -- modelo: ==
		expression = (leftResult == rightResult)
		stringExp = stringeando(model)
	elseif model == 2 then
		expression = (leftResult <= rightResult)
		stringExp = stringeando(model)
	elseif model == 3 then
		expression = (leftResult < rightResult)
		stringExp = stringeando(model)
	elseif model == 4 then
		expression = (leftResult >= rightResult)
		stringExp = stringeando(model)
	elseif model == 5 then
		expression = (leftResult > rightResult)
		stringExp = stringeando(model)
	end

	return expression, stringExp
end
