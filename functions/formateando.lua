--[[

Essa função tem como intuito formatar a posição de certos
elementos na tela. Como há regras diferentes para diferentes
strings, além da própria string como parâmetro, ela recebe 
também um modo de formatação, dependendo do valor. Default_value
é opcional e serve para que se queira retornar um valor já
definido antes. 

Ela basicamente retorna uma certa posição para que seja tomada
uma distância aceitável, para uma aparência melhor na tela.
Observe que pela diferença numerosa de formatos de expressões, 
não é possível conseguir um padrão que formate todos de maneira 
que fiquem todos exatamente na mesma posição, pelo menos não com meus conhecimentos atuais.

]]--

function formateando(stringue, mode)
	tamanho = string.len(stringue)
	contem1 = string.match(stringue, "1")
	contem1Flag = false
	extraSpace = 0 -- serve para diminuir o tamanho se o número 1 for encontrado, pois ele ocupa menos espaço
	positionFinal = 0
	
	if contem1 ~= nil then
		contem1Flag = true
		extraSpace = extraSpace + 10
	end
		
	if mode == 1 then -- modo para string booleana
		if tamanho == 1 then -- casos de '<' e '>'
			positionFinal = 420
		else
			positionFinal = 400 -- outros casos, '>=', '<=', '=='
		end
	elseif mode == 2 then -- modo para a string de expressão
		if tamanho == 3 then -- casos de 3+7 
			positionFinal = 75 - extraSpace 
		elseif tamanho == 4 then -- casos de "9+10", "-9-1"
			positionFinal = 95 - extraSpace 
		elseif tamanho == 5 then -- casos de "10+10", "21+21", "-4-17"
			positionFinal = 120 - extraSpace
		elseif tamanho == 6 then -- casos de "-10+10", "1+(-2)"
			positionFinal = 135 - extraSpace
		elseif tamanho == 7 then -- casos de "-1+(-1)"
			positionFinal = 145 - extraSpace
		elseif tamanho == 8 then -- casos de "-10+(-1)"
			positionFinal = 165 - extraSpace			
		elseif tamanho == 9 then -- casos de "-10+(-10)"
			positionFinal = 190 - extraSpace
		elseif tamanho == 10 then -- casos de "-100+(-10)
			positionFinal = 200 - extraSpace
		elseif tamanho == 11 then -- casos de "-100+(-100)"
			positionFinal = 215 -- extraSpace
		end
	elseif mode == 3 then -- modo para a string de "and not", "or not"
		if tamanho == 7 then -- caso de "and not"
			positionFinal = 50
		elseif tamanho == 6	then -- caso de "or not"	
			positionFinal = 40
		elseif tamanho == 3 then -- caso de "and"
			positionFinal = 20
		elseif tamanho == 4 then -- caso de "or"
			positionFinal = 15
		end
	elseif mode == 4 then -- mode para o The Bridge
		if tamanho == 3 then -- casos de 3+7 
			positionFinal = 270 + extraSpace 
		elseif tamanho == 4 then -- casos de "9+10", "-9-1"
			positionFinal = 250 + extraSpace 
		elseif tamanho == 5 then -- casos de "10+10", "21+21", "-4-17"
			positionFinal = 225 + extraSpace
		elseif tamanho == 6 then -- casos de "-10+10", "1+(-2)"
			positionFinal = 210 + extraSpace
		elseif tamanho == 7 then -- casos de "-1+(-1)"
			positionFinal = 200 + extraSpace
		elseif tamanho == 8 then -- casos de "-10+(-1)"
			positionFinal = 180 + extraSpace			
		elseif tamanho == 9 then -- casos de "-10+(-10)"
			positionFinal = 155 + extraSpace
		elseif tamanho == 10 then -- casos de "-100+(-10)
			positionFinal = 145 - extraSpace
		elseif tamanho == 11 then -- casos de "-100+(-100)"
			positionFinal = 130 -- extraSpace
		end
	elseif mode == 5 then
		if stringue < 0 then
			positionFinal = "(" .. stringue.. ")"
		end
	end
	return positionFinal
end