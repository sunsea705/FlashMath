--[[

Essa função tem como objetivo mudar o "nível", ou seja, aumentar a dificuldade do jogo
baseando-se no total de expressões que o jogador realizou (como se fossem exp points).

      Nível | XP necessária para o próximo nível | XP totais para o próximo nível
		1   |	10 | 10
		2	|	15 | 25
		3   |   25 | 50
		4	|   15 | 65
		5	|   14 | 79
		6	|   25 | 104
		7   |   -- | --
Novamente, quem chegar no nível 7 é MYTU. Mas não é tão dificil, acontece que o psicológico trava 
por conta do tempo, mas se o usuário tiver calma ele pode chegar no último nível.

--]]
lv2Prox, lv2Tot = 10, 25 -- 10,25
lv3Prox, lv3Tot = 25, 50 -- 25,50
lv4Prox, lv4Tot = 50, 65 -- 50, 65
lv5Prox, lv5Tot = 69, 79-- 65,79
lv6Prox, lv6Tot = 79, 104 -- 79,104
lv7Tot = 104 -- 104
 
function level_up(expPoints)

	if expPoints <= lv2Prox then
		lv = 1
	elseif expPoints > lv2Prox and expPoints <= lv2Tot then
		lv = 2
	elseif expPoints > lv3Prox and expPoints <= lv3Tot then
		lv = 3
	elseif expPoints > lv4Prox and expPoints <= lv4Tot then
		lv = 4
	elseif expPoints > lv5Prox and expPoints <= lv5Tot then
		lv = 5 
	elseif expPoints > lv6Prox and expPoints <= lv6Tot then
		lv = 6
	elseif expPoints > lv7Tot then
		lv = 7
	end
	return lv
end