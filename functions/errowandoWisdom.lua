--[[ 

Essa função é responsável por armazenar os erros do usuário
e mostrá-los na tela. Ele pega a expressão e seus números,
a resposta correta e a resposta errada do usuário e então
retorna uma string em um texto bonitinho pra ele. 
Como existem várias maneiras de se escrever estes erros, 
há um parâmetro chamado 'mode' que pega justamente a maneira
como qual a string deve ser formatada.

]]--

require "functions/numerando"
-- 3 + 7 <= 4 + 5
function errowandoWisdom(n1, op, n2, operador, mode)
	if mode == 1 then
		return n1 .. numerando(op) .. n2 .. operador
	elseif mode == 2 then
		return n1 .. numerando(op) .. n2
	elseif mode == 3 then
		return "The correct response of " .. n1 .. op .. " is: " .. tostring(n2) .. ". Your anwser: " .. tostring(operador)
	elseif mode == 4 then
		return n1 .. op .. " is: " .. tostring(n2) .. ". Your anwser: " .. tostring(operador)
	elseif mode == 5 then
		return "The correct response of " .. n1 .. op
	end
end