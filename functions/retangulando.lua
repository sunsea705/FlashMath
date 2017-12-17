--[[

Essa função indica se uma área delimitada por um retângulo
está com o mouse por cima da mesma.

]]--

function retangulando(xM, yM, xR, yR, lR, aR)

	return (xM >= xR and xM <= (xR + lR)) and (yM >= yR and yM <= (yR + aR))
	
end