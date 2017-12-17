--[[

Essa função é responsável por retornar uma string específica
dependendo do operador passado como parâmetro.

	numero	| operador correspondente
	   1		|	+ 
	   2		|	-
	   3		|	*
	   4		|	/
	   
--]]

function numerando(operador)
	if operador == 1 then
		return "+"
	elseif operador == 2 then
		return "-"
	elseif operador == 3 then
		return "*"
	elseif operador == 4 then
		return "/"
	end
end