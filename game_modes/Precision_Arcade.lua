local suit = require "functions/suit"

require "functions/numerando"
require "functions/dificulteando"
require "functions/level_up"
require "functions/operacionando"
require "functions/errowandoPrecision"

function Precision_Arcade_load()
	-- LOAD REFERENTE AO CRONÔMETRO (coloque 1 segundo a mais que o tempo especificado)
	cronometro = {
		remaining_time = 16,
		time_backup = 16, 
		stopwatch = 0,
		ending = false
	}

	-- LOAD REFERENTE A CAIXA DE TEXTO
	respostaInput = {text = "", keyEnter = false} 
	love.keyboard.setKeyRepeat(true) 

	-- LOAD REFERENTE A FONTE
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46)  
	pixel75 = love.graphics.newFont("fonts/pixel.ttf", 75)  
	pixel55 = love.graphics.newFont("fonts/pixel.ttf", 55)  
	pixel32 = love.graphics.newFont("fonts/pixel.ttf", 32)  
	digital50 = love.graphics.newFont("fonts/digital.ttf",50) 

	-- LOAD REFERENTE AS IMAGENS
	background = love.graphics.newImage("images/newRed.png")
	posX, imageWidth = 0, background:getWidth()
	
	life = love.graphics.newImage("images/heart.png")
	lifeH = love.graphics.newImage("images/heartbreak.png")
	clockI = love.graphics.newImage("images/clock.png")

	-- LOAD REFERENTE AO PLAYER E SUAS INFORMAÇÕES IN GAME
	player = {
		lifes = 3,
		score = 0,
		expCount = 0 -- XP: quantidade de acertos do jogador
	}
	
	currentLevel = 1 -- nivel atual (faixa de dificuldade)
	int1, int2, int3 = 0, 10, 2 -- faixa de intervalos para a geração de números aleatórios (inicialmente)
	
	-- LOAD REFERENTE A EXPRESSÃO
	operation = {
		num1 = nil, -- primeiro número
		num2 = nil, -- segundo número
		operador = nil, -- operador matemático (+, -, *, /)
		expressao = nil -- resultado da expressao gerada pelo primeiro e segundo número pelo operador
	}
	operation.num1, operation.num2, operation.operador, operation.expressao = operacionando(int1, int2, int3) -- gera
	-- os primeiros números aleatórios na faixa do nível 1
	
end

function love.textinput(t)
    suit.textinput(t) -- a função do love2d textinput permite pegar um texto digitado
 -- e então a função do suit pega esse texto e transforma numa caixinha bonitinha do suit
end

function love.keypressed(key)
    suit.keypressed(key) -- retorna a tecla digitada na caixinha do suit, pelo mesmo processo acima
    if key == "return" or key == "kpenter" then
		respostaInput.keyEnter = true -- se a tecla digitada for o enter,  ele muda o flag da tecla pressionada
		--para true. A utilidade disto será vista mais adiante.
    end
end

function Precision_Arcade_update(dt)

	-- VELOCIDADE DA MOVIMENTAÇÃO DO BACKGROUND
	posX = posX - 1
	
	-- SUIT: Caixa de texto
	suit.Input(respostaInput, 455, 400, 100, 30)
	
	-- CRONÔMETRO: Essa parte faz o cronômetro descrecer e atualizar seu valor
	if cronometro.ending == false then -- se o 'stop' do cronometro estiver off, ele deve descrecer o tempo
		cronometro.remaining_time = cronometro.remaining_time - dt
		cronometro.stopwatch = math.floor(cronometro.remaining_time)
	else -- senão, ele deve zerar o cronometro
		cronometro.stopwatch = 0
	end
	
	-- AUMENTANDO O NÍVEL BASEADO NO NÚMERO DE EXPRESSÕES DO JOGADOR 
	currentLevel = level_up(player.expCount) -- muda o nível atual do jogo através da função level_up(), que usa os XP do jogador para tal
	int1, int2, int3 = dificulteando(currentLevel) -- muda a faixa de números, baseado no nível atual, através da função
	-- dificulteando()
	
	-- BOTÃO PARA REINICIAR O JOGO 	Org: 220, 20, 250,40
	if suit.Button("Reset Game", 150, 450, 250,40 ).hit then 
		int1, int2, int3 = 0, 10, 2 
		player.lifes, player.score, player.expCount = 3, 0, 0 -- resetando os dados do player
		currentLevel = 1 -- voltando a primeira fase
		cronometro.ending, cronometro.remaining_time = false, cronometro.time_backup -- resetando cronometro
		respostaInput.text, respostaInput.keyEnter = "", false -- resetando os dados caixa de texto
		-- GERANDO NOVOS NÚMEROS ALEATÓRIOS
		operation.num1, operation.num2, operation.operador, operation.expressao = operacionando(int1, int2, int3)
	
    end
	
	-- BOTÃO PARA RETORNAR AO MENU INICIAL  Org: 495, 20, 250, 40
	if suit.Button("Back To Select Mode", 425, 450, 365, 40 ).hit then
		select_mode()
	end

end

function Precision_Arcade_draw()
	-- DESENHANDO O BACKGROUND ANIMADO(SEMPRE COLOCAR PRIMEIRO)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(background, posX, 0)
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
	love.graphics.print("Lives: " , 20, 20 )
	love.graphics.draw(l1, 90, 30)
	love.graphics.draw(l2, 124, 30)
	love.graphics.draw(l3, 158, 30)
	
	-- SUIT: DESENHANDO OS BOTÕES E A CAIXA DE TEXTO 
	suit.draw()
	
	-- DESENHANDO E ATUALIZANDO O CRONÔMETRO DA TELA (e um reloginho)
	love.graphics.setFont(digital50)
	love.graphics.draw(clockI, 350, 90)
	
	if cronometro.stopwatch >= 10 then 
		love.graphics.print("0:".. cronometro.stopwatch, 390,100) -- 0:15
	else
		love.graphics.print("0:0".. cronometro.stopwatch, 390,100) -- 0:09
	end

	-- ALMA DO JOGO: VERIFICANDO SE A RESPOSTA DA EXPRESSÃO CRIADA É IGUAL AO QUE O JOGADOR DIGITA
	if player.lifes > 0 then
		if respostaInput.keyEnter or cronometro.stopwatch < 0 then
			if tonumber(respostaInput.text) == operation.expressao then
				player.score = player.score + cronometro.stopwatch
				player.expCount = player.expCount + 1
			else
				player.lifes = player.lifes - 1
				errow = errowandoPrecision(operation.num1, operation.operador, operation.num2, operation.expressao, respostaInput.text)
				if player.lifes == 2 then
					errow1 = errow 
				elseif player.lifes == 1 then
					errow2 = errow
				elseif player.lifes == 0 then
					errow3 = errow
				end
			end
			cronometro.remaining_time = cronometro.time_backup
			respostaInput.text, respostaInput.keyEnter = "", false
			-- GERANDO NOVOS NÚMEROS ALEATÓRIOS
			operation.num1, operation.num2, operation.operador, operation.expressao = operacionando(int1, int2, int3, -1)
			
		end
	else
		love.graphics.setFont(pixel32)
		love.graphics.print("Check your wrong awnsers below:", 150, 240)
		love.graphics.print(errow1, 150, 260)
		love.graphics.print(errow2, 150, 280)
		love.graphics.print(errow3, 150, 300)
		cronometro.ending = true
	end
	
	-- IMPRIMINDO A EXPRESSÃO NA TELA
	printi = operation.num1 .. numerando(operation.operador) .. operation.num2 .. " = ?"
	printi_backup = printi

	love.graphics.setFont(digital50) -- 360, 175
	if cronometro.ending == true then
		printi = "GAME OVER"
	else
		if operation.num2 < 0 then
			printi = operation.num1 .. numerando(operation.operador) .. "(" .. operation.num2 .. ")" .. " = ?"
		else
			printi = printi_backup
		end
	end
	love.graphics.print(printi, 360, 175)
	
	-- MOSTRANDO OUTROS ELEMENTOS NA TELA
	love.graphics.setFont(pixel55)
	love.graphics.print("Score ", 770, 3)
	
	love.graphics.rectangle("line", 740, 45, 150, 45)
	
	love.graphics.setFont(pixel75)
	love.graphics.print(player.score, 743, 35)
	
	love.graphics.setFont(pixel46)
	love.graphics.print("Awnser: ", 355, 400)

end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end