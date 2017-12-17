--[[ 

Essa função é responsável por armazenar os erros do usuário
e mostrá-los na tela. Ele pega a expressão e seus números,
a resposta correta e a resposta errada do usuário e então
retorna uma string em um texto bonitinho pra ele.

]]--

require "functions/numerando"

function errowandoPrecision(n1, op, n2, correct, user)
	p1 = "The correct response of " 
	p2 = " is " 
	p3 = ". Your answer: " 
	p4 = "("
	p5 = ")"
	
	errow = p1 .. n1 .. numerando(op) .. n2 .. p2 .. correct .. p3 .. user
	if n2 < 0 then
		errow = p1 .. n1 .. numerando(op) .. p4 .. n2 .. p5 .. p2 .. correct .. p3 .. user
	end
	
	return errow
end