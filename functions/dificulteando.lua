--[[

Essa função tem como objetivo gerar uma faixa de intervalos numéricos especificada,
tendo como base o "nível" atual do jogo. Entende-se por nível não como uma fase, mas sim
como um marcador de que a dificuldade deve aumentar.
O jogador "sobe de nível" através da função level_up que usa como parâmetro 
a quantidade de expressões que o usuário já conseguiu acertar. Didaticamente, 
ele passa para o próximo nível quando atinge certos pontos de xp.

O número máximo que o nível pode chegar é a 7.

     Nível  | Números   | Operações   | XP necessária para o próximo nível | (Wisdom) Operadores
		1   | 0 a 10    | + e - 	  | 	10							   | ==, <, >, <=, >=
		2	| -10 a 20  | + e -		  |		15							   | ==, <, >, <=, >=
		3   | -25 a 50  | + e -		  |     13							   | ==, <, >, <=, >=
		4	| -5 a 15   | +, -, * e / |		15							   | ==, <, >, <=, >=, and, or, and not, or not
		5	| -10 a 20  | +, -, * e / |		12							   | ==, <, >, <=, >=, and, or, and not, or not
		6	| -25 a 50  | +, -, * e / |		20							   | ==, <, >, <=, >=, and, or, and not, or not
		7   |-100 a 100 | +, -, * e / |		--							   | ==, <, >, <=, >=, and, or, and not, or not
		
Quem conseguir chegar no nível 7 é fodástico hein.


--]]

function dificulteando(level) 
	if level == 1 then
		n1, n2, op = 1, 10, 2
	elseif level == 2 then
		n1, n2, op = -10, 20, 2
	elseif level == 3 then
		n1, n2, op = -25, 50, 2
	elseif level == 4 then
		n1, n2, op = -5, 15, 4
	elseif level == 5 then
		n1, n2, op = -10, 20, 4
	elseif level == 6 then
		n1, n2, op = -25, 50, 4
	elseif level == 7 then -- note que não era necessário este elseif, só coloquei mesmo para eu não me perder 
		n1, n2, op = -100, 100, 4
	end

	return n1, n2, op
end