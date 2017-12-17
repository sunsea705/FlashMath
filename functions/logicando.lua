require "functions/stringeando"
math.randomseed(os.time())

function logicando(final1, final2)
	buffer = math.random(6,9); logic = math.random(6,9) -- escolhendo o número do operador lógico aleatoriamente

	if logic == 6 then
		expression = (final1 and final2) -- x + y >= y + y AND x - y < x + x
		stringExp = stringeando(logic)
	elseif logic == 7 then
		expression = (final1 or final2) -- x + y >= y + y OR x - y < x + x
		stringExp = stringeando(logic)
	elseif logic == 8 then
		expression = (final1 and not final2) -- x + y >= y + y AND NOT x - y < x + x
		stringExp = stringeando(logic)
	elseif logic == 9 then
		expression = (final1 or not final2) -- x + y >= y + y OR NOT x - y < x + x
		stringExp = stringeando(logic)
	end
	return expression, stringExp
end