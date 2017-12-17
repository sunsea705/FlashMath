local suit = require "functions/suit"

require "functions/numerando"
require "functions/dificulteando"
require "functions/level_up"
require "functions/operacionando"
require "functions/errowandoWisdom"
require "functions/stringeando"
require "functions/modelando"
require "functions/logicando"
require "functions/formateando"

function WisdomTimeAttack_load()
	-- LOAD REFERENTE AO CRONÔMETRO (coloque 1 segundo a mais que o tempo especificado)
	cronos = "1:" -- valor inicial da string formatadora do relógio
	cronometro = {
		remaining_time1 = 60, -- Dois cronômetros diferentes, um contando de 0:30 e outro de 0:59
		remaining_time2 = 31, -- para que haja a formatação do tempo com 1:30 até 0:00 -- Org: 60 e 31
		time_backup1 = 60,
		time_backup2 = 31,
		stopwatch = 0,
		cronometro1 = true, -- flags que permitem cada cronometro ser 'ligado' ou não
		cronometro2 = true
	}
	
	-- LOAD REFERENTE A FONTE
	pixel28 = love.graphics.newFont("fonts/pixel.ttf", 28)
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46)  
	pixel75 = love.graphics.newFont("fonts/pixel.ttf", 75)  
	pixel55 = love.graphics.newFont("fonts/pixel.ttf", 55)  
	pixel32 = love.graphics.newFont("fonts/pixel.ttf", 32)  
	digital50 = love.graphics.newFont("fonts/digital.ttf",50) 
	digital75 = love.graphics.newFont("fonts/digital.ttf",65) 
	courier50 = love.graphics.newFont("fonts/courierNew.ttf",40)

	-- LOAD REFERENTE AS IMAGENS
	background = love.graphics.newImage("images/newBlue.png")
	posX, imageWidth = 0, background:getWidth()
	
	life = love.graphics.newImage("images/heart.png")
	lifeH = love.graphics.newImage("images/heartbreak.png")
	clockI = love.graphics.newImage("images/clock.png")

	-- LOAD REFERENTE AO PLAYER
	player = {
		lifes = 1,
		score = 0,
		expCount = 0 -- XP: quantidade de acertos do jogador
	}
	
	currentLevel = 1 -- nivel atual
	int1, int2, int3 = 0, 10, 2 -- faixa de intervalos para a geração de números aleatórios
	
	-- LOAD REFERENTE A (MINI) EVENTOS DE CLIQUE
	click = {
		clickAwnser = "not clicked",
		clicked = false
	}
	
	-- LOAD REFERENTE AS EXPRESSÕES
	operation1 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		leftResult = nil -- resultado da expressao gerada pelo primeiro e segundo número pelo operador
	}
	
	operation2 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		rightResult = nil -- resultado da expressao gerada pelo primeiro e segundo número pelo operador
	}
	
	operation3 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		leftResult = nil -- resultado da expressao gerada pelo primeiro e segundo número pelo operador
	}
	
	operation4 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		rightResult = nil -- resultado da expressao gerada pelo primeiro e segundo número pelo operador
	}
	-- GERANDO QUATRO EXPRESSÕES NUMÉRICAS
	operation1.num1, operation1.num2, operation1.operador, operation1.leftResult = operacionando(int1, int2, int3) -- 2
	operation2.num1, operation2.num2, operation2.operador, operation2.rightResult = operacionando(int1, int2, int3)
	operation3.num1, operation3.num2, operation3.operador, operation3.leftResult = operacionando(int1, int2, int3)
	operation4.num1, operation4.num2, operation4.operador, operation4.rightResult = operacionando(int1, int2, int3)
	-- GERANDO DOIS PARES DE EXPRESSÕES LÓGICAS
	boolOperation1, stringBool1 = modelando(operation1.leftResult, operation2.rightResult)
	boolOperation2, stringBool2 = modelando(operation3.leftResult, operation4.rightResult)
	finalBoolOperation, finalStringBool = logicando(boolOperation1, boolOperation2)
	
	finalyResult, doubleImp = boolOperation1, false
		
end

function WisdomTimeAttack_update(dt)
	-- VELOCIDADE DA MOVIMENTAÇÃO DO BACKGROUND
	posX = posX - 1
	
	-- BOTÃO PARA REINICIAR O JOGO 	Org: 220, 20, 250,40
	if resBtn.hit then 
		int1, int2, int3 = 0, 10, 2 -- intervalos iniciais da faixa de números gerados
		player.lifes, player.score, player.expCount = 1, 0, 0 -- resetando os dados do player
		currentLevel = 1 -- voltando a primeira fase (primeiro nível de dificuldade)
		cronometro.cronometro1, cronometro.cronometro2 = true, true -- religando os dois cronometros
		cronometro.remaining_time1, cronometro.remaining_time2 = cronometro.time_backup1, cronometro.time_backup2-- resetando cronometro
		-- GERANDO NOVOS NÚMEROS ALEATÓRIOS
		operation1.num1, operation1.num2, operation1.operador, operation1.leftResult = operacionando(int1, int2, int3)
		operation2.num1, operation2.num2, operation2.operador, operation2.rightResult = operacionando(int1, int2, int3)
		operation3.num1, operation3.num2, operation3.operador, operation3.leftResult = operacionando(int1, int2, int3)
		operation4.num1, operation4.num2, operation4.operador, operation4.rightResult = operacionando(int1, int2, int3)
		-- GERANDO DOIS PARES DE EXPRESSÕES LÓGICAS
		boolOperation1, stringBool1 = modelando(operation1.leftResult, operation2.rightResult)
		boolOperation2, stringBool2 = modelando(operation3.leftResult, operation4.rightResult)
		finalBoolOperation, finalStringBool = logicando(boolOperation1, boolOperation2)
    end
	
	-- CRONÔMETRO: Essa parte faz os  dois cronômetros descrecerem e atualizarem seu valor
	if cronometro.cronometro1 then -- se o primeiro cronometro puder ser ligado, então o cronometro deve rodar
		if cronometro.cronometro2 then -- se o segundo está 'on', então começa a contar o cronometro de 0:30
			cronometro.remaining_time2 = cronometro.remaining_time2 - dt
			cronometro.stopwatch = math.floor(cronometro.remaining_time2)
			if cronometro.stopwatch < 0 then -- se ele chegar a zero, ele deve desligar esse cronometro e contar
				cronometro.cronometro2 = false -- o primeiro
			end
		else -- como o outro está desligado e este ligado, agora ele começa a contar o cronometro de 0:59
			cronometro.remaining_time1 = cronometro.remaining_time1 - dt
			cronometro.stopwatch = math.floor(cronometro.remaining_time1)
			if cronometro.stopwatch < 0 then
				click.clickAwnser = ""
				player.lifes = 0 -- se o cronometro chegar a zero significa que o usuário não respondeu a pergunta
			end -- e o tempo se esgotou
		end
	else -- se este cronometro estiver 'off' então ele deve deixar o cronometro zerado.
		cronometro.stopwatch = 0
		cronos = "0:0"
	end

	-- FORMATAÇÃO VISUAL DO CRONÔMETRO DE 1:30 NA TELA
	if cronometro.cronometro2 then -- se o segundo cronometro estiver 'on', então ele deve formatar de acordo com
		if cronometro.stopwatch >= 10 then -- este cronometro, ou seja, mostrando o "1:" na tela
			cronos = "1:"
		else
			cronos = "1:0"
		end
	else -- senão, ele deve formatar de acordo com o outro cronometro, mostrando o "0:" na tela
		if cronometro.stopwatch >= 10 then
			cronos = "0:"
		else
			cronos = "0:0"
		end
	end
	
	-- AUMENTANDO O NÍVEL BASEADO NO NÚMERO DE EXPRESSÕES DO JOGADOR 
	currentLevel = level_up(player.expCount) -- muda o nível atual do jogo através da função level_up()
	int1, int2, int3 = dificulteando(currentLevel)
	-- muda a faixa de números, baseado no nível atual, através da função
	-- dificulteando()
	if currentLevel >= 4 then -- aumenta a dificuldade a partir do nível 4, exibindo expressões com AND, OR, NOT
		doubleImp = true 
		finalyResult = finalBoolOperation -- o que significa que o valor lógico a ser comparado muda
	else
		doubleImp = false -- senão, ele imprime uma única expressão 
		finalyResult = boolOperation1
	end
	
	-- MUDANDO OS VALORES DOS BOTÕES DE VERDADEIRO OU FALSO
	if btnTrue.hit then 
		click.clickAwnser = true -- a resposta do usuário muda pra user
		click.clicked = true -- e a flag do "algo foi clicado" muda pra true (análogo ao respostaInput.keyEnter)
	elseif btnFalse.hit then
		click.clickAwnser = false
		click.clicked = true
	else
		click.clicked = false
	end
	
	
	-- BOTÃO PARA RETORNAR AO MENU INICIAL  Org: 495, 20, 250, 40
	if btnMainMenu.hit then
		select_mode()
	end

end

function WisdomTimeAttack_draw()
	-- DESENHANDO O BACKGROUND ANIMADO(SEMPRE COLOCAR PRIMEIRO)
	love.graphics.draw(background, posX, 0) 
    love.graphics.draw(background, posX + imageWidth, 0)

	if posX <= -imageWidth then
		posX = 0
	end
	
	-- DESENHANDO E ATUALIZANDO O VALOR DAS VIDAS NA TELA
	l1 = life -- mega simples, se a vida for 1, a imagem é heart
	if player.lifes == 0 then -- senão, é heartbreak
		l1 = lifeH
	end
	
	love.graphics.setFont(pixel46)
	love.graphics.print("Lives: " , 20, 20 )
	love.graphics.draw(l1, 90, 30)
	
	-- SUIT: DESENHANDO OS BOTÕES 
	love.graphics.setFont(pixel46)
	resBtn = suit.Button("Reset Game", 150, 450, 250,40 )
	btnMainMenu = suit.Button("Back To Select Mode", 425, 450, 365, 40 )
	btnTrue = suit.Button("True?", 300, 365, 125,50)
	btnFalse = suit.Button("False?", 475, 365, 125,50)
	suit.draw()
	
	-- DESENHANDO E ATUALIZANDO O CRONÔMETRO DA TELA (e um reloginho)
	love.graphics.setFont(digital50)
	love.graphics.draw(clockI, 350, 40)
	love.graphics.print(cronos .. cronometro.stopwatch, 390, 50) -- imprime a string formatada junto com o tempo
	-- atual do cronometro que está sendo descrescido no momento
	
	-- ALMA DO JOGO: VERIFICANDO SE A RESPOSTA DITA PELO USUÁRIO É A MESMA DA EXPRESSÃO GERADA
	if player.lifes > 0 then
		errow1 = errowandoWisdom(operation1.num1, operation1.operador, operation1.num2, stringBool1, 1)
		errow2 = errowandoWisdom(operation2.num1, operation2.operador, operation2.num2, 0, 2)
		finalyErrow = errowandoWisdom(errow1, errow2, finalyResult, click.clickAwnser, 3)
		if currentLevel >= 4 then
			errow3 = errowandoWisdom(operation3.num1, operation3.operador, operation3.num2, stringBool2, 1)
			errow4 = errowandoWisdom(operation4.num1, operation4.operador, operation4.num2, 0, 2)
			finalyErrowAux1 = errowandoWisdom(errow1, errow2, 0, 0, 5)
			finalyErrowAux2 = errowandoWisdom(errow3, errow4, finalyResult, click.clickAwnser, 4)
			finalyErrow = finalyErrowAux1 .. " " .. finalStringBool .. " " .. finalyErrowAux2
		end
		if click.clicked or cronometro.stopwatch < 0 then -- Essa condição jamais será falsa
			if click.clickAwnser == finalyResult then
				player.expCount = player.expCount + 1
				player.score = player.expCount
			else
				player.lifes = player.lifes - 1
				cronometro.cronometro1 = false -- desligando o primeiro cronometro pois as vidas acabaram		
			end
			cronometro.remaining_time = cronometro.time_backup
			-- GERANDO NOVOS NÚMEROS ALEATÓRIOS
			operation1.num1, operation1.num2, operation1.operador, operation1.leftResult = operacionando(int1, int2, int3)
			operation2.num1, operation2.num2, operation2.operador, operation2.rightResult = operacionando(int1, int2, int3)
			operation3.num1, operation3.num2, operation3.operador, operation3.leftResult = operacionando(int1, int2, int3)
			operation4.num1, operation4.num2, operation4.operador, operation4.rightResult = operacionando(int1, int2, int3)
			-- GERANDO DOIS PARES DE EXPRESSÕES LÓGICAS NOVINHAS
			boolOperation1, stringBool1 = modelando(operation1.leftResult, operation2.rightResult)
			boolOperation2, stringBool2 = modelando(operation3.leftResult, operation4.rightResult)
			finalBoolOperation, finalStringBool = logicando(boolOperation1, boolOperation2)
		end
	else
		love.graphics.setFont(pixel32)
		love.graphics.print("Check your wrong awnser below:", 150, 240)
		love.graphics.print(finalyErrow, 150, 260)
		cronometro.cronometro1 = false
		cronometro.cronometro2 = false
	end
	
	if operation1.num2 < 0 then
		printi1 = operation1.num1 .. numerando(operation1.operador) .. "(" .. operation1.num2 .. ")"		-- 2 + 3
	else
		printi1 = operation1.num1 .. numerando(operation1.operador) .. operation1.num2
	end
	if operation2.num2 < 0 then
		printi2 = operation2.num1 .. numerando(operation2.operador) .. "(" .. operation2.num2 .. ")"		-- 2 + 3
	else
		printi2 = operation2.num1 .. numerando(operation2.operador) .. operation2.num2
	end
	if operation3.num2 < 0 then
		printi3 = operation3.num1 .. numerando(operation3.operador) .. "(" .. operation3.num2 .. ")"		-- 2 + 3
	else
		printi3 = operation3.num1 .. numerando(operation3.operador) .. operation3.num2
	end
	if operation4.num2 < 0 then
		printi4 = operation4.num1 .. numerando(operation4.operador) .. "(" .. operation4.num2 .. ")"		-- 2 + 3
	else
		printi4 = operation4.num1 .. numerando(operation4.operador) .. operation4.num2
	end
	
	love.graphics.setFont(digital75) 
	if cronometro.ending == true then
		love.graphics.print("GAME OVER", 290, 175)
	else
		love.graphics.setFont(digital50)
		love.graphics.print(stringBool1, formateando(stringBool1, 1), 130)
		love.graphics.print(printi1, formateando(stringBool1, 1) - formateando(printi1, 2), 130)
		love.graphics.print(printi2, 450, 130)
		if doubleImp then -- significa que precisa exibir duas partes
			love.graphics.setFont(courier50)
			love.graphics.print(finalStringBool, formateando(stringBool1, 1) - formateando(finalStringBool, 3), 150)
		
			love.graphics.setFont(digital50)
			love.graphics.print(stringBool2, formateando(stringBool2, 1, 0), 210)
			love.graphics.print(printi3, formateando(stringBool2, 1, 0) - formateando(printi3, 2, 0), 210)
			love.graphics.print(printi4, 450, 210)	
		end
	end
	-- MOSTRANDO OUTROS ELEMENTOS NA TELA
	love.graphics.setFont(pixel55)
	love.graphics.print("Expressions", 725, 3)
	love.graphics.rectangle("line", 725, 45, 170, 45) -- retângulo do score
	love.graphics.setFont(pixel75)
	love.graphics.print(player.score, 727, 35)
	
end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end