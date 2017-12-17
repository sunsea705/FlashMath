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

function WisdomArcade_load()
	-- LOAD REFERENTE AO CRONÔMETRO (coloque 1 segundo a mais que o tempo especificado)
	cronometro = {
		remaining_time = 16,
		time_backup = 16, 
		stopwatch = 0,
		ending = false
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
		lifes = 3,
		score = 0,
		expCount = 0 -- XP: quantidade de acertos do jogador
	}
	
	currentLevel = 1 -- nivel atual
	int1, int2, int3 = 0, 10, 2 -- faixa de intervalos para a geração de números aleatórios
	
	-- LOAD REFERENTE A (MINI) EVENTOS DE CLIQUE
	click = {
		clickAwnser = "not clicked", -- resposta do clique
		clicked = false -- flag se houve o clique em algum botão
	}
	
	-- LOAD REFERENTE AS EXPRESSÕES (4, pois o jogo opera com 2 ou 4 expressões durante o game)
	operation1 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		leftResult = nil -- resultado da expressao gerada do 'lado esquerdo', pois ele fica do lado esquerdo ao operador comparativo
	}
	
	operation2 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		rightResult = nil -- resultado da expressao gerada do 'lado direito', pois ele fica do lado direito ao operador comparativo
	}
	
	operation3 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		leftResult = nil -- resultado da expressao gerada do 'lado esquerdo', pois ele fica do lado esquerdo ao operador comparativo
	}
	
	operation4 = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		rightResult = nil -- resultado da expressao gerada pelo primeiro e segundo número pelo operador
	}
	-- GERANDO QUATRO EXPRESSÕES NUMÉRICAS
	operation1.num1, operation1.num2, operation1.operador, operation1.leftResult = operacionando(int1, int2, int3) 
	operation2.num1, operation2.num2, operation2.operador, operation2.rightResult = operacionando(int1, int2, int3)
	operation3.num1, operation3.num2, operation3.operador, operation3.leftResult = operacionando(int1, int2, int3)
	operation4.num1, operation4.num2, operation4.operador, operation4.rightResult = operacionando(int1, int2, int3)
	-- GERANDO DOIS PARES DE EXPRESSÕES COMPARATIVAS 
	boolOperation1, stringBool1 = modelando(operation1.leftResult, operation2.rightResult)
	boolOperation2, stringBool2 = modelando(operation3.leftResult, operation4.rightResult)
	-- E FINALMENTE, GERANDO UMA EXPRESSÃO LÓGICA COMPLETA
	finalBoolOperation, finalStringBool = logicando(boolOperation1, boolOperation2)
	
	-- RESULTADO FINAL A SER COMPARADO A RESPOSTA DO USUÁRIO
	finalyResult, doubleImp = boolOperation1, false 
		
end

function WisdomArcade_update(dt)
	-- VELOCIDADE DA MOVIMENTAÇÃO DO BACKGROUND
	posX = posX - 1
	
	-- BOTÃO PARA REINICIAR O JOGO 	Org: 220, 20, 250,40
	if resBtn.hit then 
		int1, int2, int3 = 0, 10, 2 
		player.lifes, player.score, player.expCount = 3, 0, 0 -- resetando os dados do player
		currentLevel = 1 -- voltando a primeira fase (primeiro nível de dificuldade)
		cronometro.ending, cronometro.remaining_time = false, cronometro.time_backup -- resetando cronometro
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
	
	-- CRONÔMETRO: Essa parte faz o cronômetro descrecer e atualizar seu valor
	if cronometro.ending == false then -- se o 'stop' do cronometro estiver off, ele deve descrecer o tempo
		cronometro.remaining_time = cronometro.remaining_time - dt
		cronometro.stopwatch = math.floor(cronometro.remaining_time)
		if cronometro.stopwatch < 0 then
			click.clickAwnser = "" -- se o cronometro chegar a zero o usuário DEVE perder uma vida
		end
	else -- senão, ele deve zerar o cronometro
		cronometro.stopwatch = 0
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
	
	-- BOTÃO PARA RETORNAR AO MENU INICIAL  Org: 495, 20, 250, 40
	if btnMainMenu.hit then
		select_mode()
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

end

function WisdomArcade_draw()
	-- DESENHANDO O BACKGROUND ANIMADO(SEMPRE COLOCAR PRIMEIRO)
	love.graphics.draw(background, posX, 0) -- this is the original image
    love.graphics.draw(background, posX + imageWidth, 0)

	if posX <= -imageWidth then
		posX = 0
	end
	
	-- DESENHANDO E ATUALIZANDO O VALOR DAS VIDAS NA TELA
	l1, l2, l3 = life, life, life -- as imagens das vidas começam com heart, já que as vidas são 3
	if player.lifes <= 2 then -- se a vida for menor ou igual a 2, a ultima vida é trocada pelo heartbreak
		l3 = lifeH
		if player.lifes <= 1 then -- e em consequencia a segunda
			l2 = lifeH
		end
		if player.lifes == 0 then -- e por fim, a última
			l1 = lifeH
		end
	end
	love.graphics.setFont(pixel46)
	love.graphics.print("Lives: " , 20, 20 )
	love.graphics.draw(l1, 90, 30)
	love.graphics.draw(l2, 124, 30)
	love.graphics.draw(l3, 158, 30)
	
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
	
	if cronometro.stopwatch >= 10 then -- suit.Label
		love.graphics.print("0:".. cronometro.stopwatch, 390,50) -- 0:09
	else
		love.graphics.print("0:0".. cronometro.stopwatch, 390,50)
	end
	
	-- ALMA DO JOGO: VERIFICANDO SE A RESPOSTA DITA PELO USUÁRIO É A MESMA DA EXPRESSÃO GERADA
	if player.lifes > 0 then
		if click.clicked or cronometro.stopwatch < 0 then -- Essa condição jamais será falsa
			if click.clickAwnser == finalyResult then
				player.score = player.score + cronometro.stopwatch
				player.expCount = player.expCount + 1
			else
				player.lifes = player.lifes - 1
				if player.lifes == 2 then
					errow1 = errowandoWisdom(operation1.num1, operation1.operador, operation1.num2, stringBool1, 1)
					errow2 = errowandoWisdom(operation2.num1, operation2.operador, operation2.num2, 0, 2)
					finalyErrow5 = errowandoWisdom(errow1, errow2, finalyResult, click.clickAwnser, 3)
					if currentLevel >= 4 then
						errow3 = errowandoWisdom(operation3.num1, operation3.operador, operation3.num2, stringBool2, 1)
						errow4 = errowandoWisdom(operation4.num1, operation4.operador, operation4.num2, 0, 2)
						finalyErrow5 = errowandoWisdom(errow1, errow2, 0, 0, 5)
						finalyErrow2 = errowandoWisdom(errow3, errow4, finalyResult, click.clickAwnser, 4)
						finalyErrow5 = finalyErrow5 .. " " .. finalStringBool .. " " .. finalyErrow2
					end
				end
				if player.lifes == 1 then
					errow1 = errowandoWisdom(operation1.num1, operation1.operador, operation1.num2, stringBool1, 1)
					errow2 = errowandoWisdom(operation2.num1, operation2.operador, operation2.num2, 0, 2)
					finalyErrow3 = errowandoWisdom(errow1, errow2, finalyResult, click.clickAwnser, 3)
					if currentLevel >= 4 then
						errow3 = errowandoWisdom(operation3.num1, operation3.operador, operation3.num2, stringBool2, 1)
						errow4 = errowandoWisdom(operation4.num1, operation4.operador, operation4.num2, 0, 2)
						finalyErrow3 = errowandoWisdom(errow1, errow2, 0, 0, 5)
						finalyErrow2 = errowandoWisdom(errow3, errow4, finalyResult, click.clickAwnser, 4)
						finalyErrow3 = finalyErrow3 .. " " .. finalStringBool .. " " .. finalyErrow2
					end
				end
				if player.lifes == 0 then
					errow1 = errowandoWisdom(operation1.num1, operation1.operador, operation1.num2, stringBool1, 1)
					errow2 = errowandoWisdom(operation2.num1, operation2.operador, operation2.num2, 0, 2)
					finalyErrow4 = errowandoWisdom(errow1, errow2, finalyResult, click.clickAwnser, 3)
					if currentLevel >= 4 then
						errow3 = errowandoWisdom(operation3.num1, operation3.operador, operation3.num2, stringBool2, 1)
						errow4 = errowandoWisdom(operation4.num1, operation4.operador, operation4.num2, 0, 2)
						finalyErrow1 = errowandoWisdom(errow1, errow2, 0, 0, 5)
						finalyErrow2 = errowandoWisdom(errow3, errow4, finalyResult, click.clickAwnser, 4)
						finalyErrow4 = finalyErrow1 .. " " .. finalStringBool .. " " .. finalyErrow2
					end
				end
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
		love.graphics.print("Check your wrong awnsers below:", 150, 240)
		love.graphics.print(finalyErrow5, 150, 260)
		love.graphics.print(finalyErrow3, 150, 280)
		love.graphics.print(finalyErrow4, 150, 300)
		cronometro.ending = true
	end
	
	-- IMPRIMINDO A EXPRESSÃO NA TELA 
	-- Apesar do código ser grande e complexo, imagina uma linha de código com todos esses termos concatenados?
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
	if cronometro.ending then
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
	love.graphics.print("Score ", 770, 3)
	love.graphics.rectangle("line", 740, 45, 150, 45) -- retângulo do score
	love.graphics.setFont(pixel75)
	love.graphics.print(player.score, 743, 35)
	
end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end