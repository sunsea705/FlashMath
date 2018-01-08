--[[ Essa função simples pega um número que seja negativo
e retorna ele formatado com um parênteses.
]]--

function paranteseando(numero)
	if numero < 0 then
		return "(" .. numero .. ")"
	end
	return numero
end