local suit = require "functions/suit"

require "functions/numerando"
require "functions/dificulteando"
require "functions/level_up"
require "functions/operacionando"
require "functions/errowandoPrecision"

function Precision_TimeAttack_load()
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

	-- LOAD REFERENTE AO PLAYER
	player = {
		lifes = 1,
		score = 0,
		expCount = 0 -- XP: quantidade de acertos do jogador
	}

	currentLevel = 1 -- nivel atual
	int1, int2, int3 = 0, 10, 2 -- faixa de intervalos para a geração de números aleatórios

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
	end
end

function Precision_TimeAttack_update(dt)

	-- VELOCIDADE DA MOVIMENTAÇÃO DO BACKGROUND
	posX = posX - 1

	-- SUIT: Caixa de texto
	suit.Input(respostaInput, 455, 400, 100, 30)

	-- CRONÔMETRO: Essa parte faz os  dois cronômetros descrecerem e atualizarem seu valor, conforme o momento
	if cronometro.cronometro1 then -- se o primeiro cronometro puder ser ligado, então o cronometro 'como um todo' deve rodar
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
				player.lifes = 0 -- se o cronometro chegar a zero significa que o usuário não respondeu a pergunta
			end -- e o tempo se esgotou
		end
	else -- se este cronometro estiver 'off' então todos os cronometros devem ser desligados. Ele deve deixar o cronometro zerado.
		cronometro.stopwatch = 0
		cronos = "0:0"
	end

	-- FORMATAÇÃO VISUAL DO CRONÔMETRO DE 1:30 NA TELA, MUDANDO A VARIÁVEL CRONOS
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
	int1, int2, int3 = dificulteando(currentLevel) -- muda a faixa de números, baseado no nível atual, através da função
	-- dificulteando()

	-- BOTÃO PARA REINICIAR O JOGO 	Org: 220, 20, 250,40
	if suit.Button("Reset Game", 150, 450, 250,40 ).hit then
		int1, int2, int3 = 0, 10, 2 
		player.lifes, player.score, player.expCount = 1, 0, 0 -- resetando os dados do player
		currentLevel = 1 -- voltando a primeira fase
		cronometro.cronometro1, cronometro.cronometro2 = true, true -- religando os dois cronometros
		cronometro.remaining_time1, cronometro.remaining_time2 = cronometro.time_backup1, cronometro.time_backup2-- resetando cronometro
		respostaInput.text, respostaInput.keyEnter = "", false -- resetando os dados caixa de texto
		-- GERANDO NOVOS NÚMEROS ALEATÓRIOS
		operation.num1, operation.num2, operation.operador, operation.expressao = operacionando(int1, int2, int3)

    end

	-- BOTÃO PARA RETORNAR AO MENU INICIAL  Org: 495, 20, 250, 40
	if suit.Button("Back To Select Mode", 425, 450, 365, 40 ).hit then
		select_mode()
	end

end

function Precision_TimeAttack_draw()
	-- DESENHANDO O BACKGROUND ANIMADO(SEMPRE COLOCAR PRIMEIRO)
	love.graphics.setColor(255,255,255)
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
	love.graphics.print("Lives: " , 20, 20 )
	love.graphics.draw(l1, 90, 30)

	-- SUIT: DESENHANDO OS BOTÕES E A CAIXA DE TEXTO
	suit.draw()

	-- DESENHANDO E ATUALIZANDO O CRONÔMETRO DA TELA (e um reloginho)
	love.graphics.setFont(digital50)
	love.graphics.draw(clockI, 350, 90)
	love.graphics.print(cronos .. cronometro.stopwatch, 390, 100) -- imprime a string formatada junto com o tempo
	-- atual do cronometro que está sendo descrescido no momento

	-- ALMA DO JOGO: VERIFICANDO SE A RESPOSTA DA EXPRESSÃO CRIADA É IGUAL AO QUE O JOGADOR DIGITA
	if player.lifes > 0 then
		errow = errowandoPrecision(operation.num1, operation.operador, operation.num2, operation.expressao, respostaInput.text)
		if respostaInput.keyEnter then
			if tonumber(respostaInput.text) == operation.expressao then
				player.expCount = player.expCount + 1
				player.score = player.expCount
			else
				player.lifes = player.lifes - 1
				cronometro.cronometro1 = false -- desligando o primeiro cronometro pois as vidas acabaram
			end
			respostaInput.text, respostaInput.keyEnter = "", false
			-- GERANDO NOVOS NÚMEROS ALEATÓRIOS
			operation.num1, operation.num2, operation.operador, operation.expressao = operacionando(int1, int2, int3, -1)

		end
	else
		love.graphics.setFont(pixel32)
		love.graphics.print("Check your wrong awnser below:", 150, 240)
		love.graphics.print(errow, 150, 260)
		cronometro.cronometro1 = false
		cronometro.cronometro2 = false
	end

	-- IMPRIMINDO A EXPRESSÃO NA TELA
	printi = operation.num1 .. numerando(operation.operador) .. operation.num2 .. " = ?"
	printi_backup = printi

	love.graphics.setFont(digital50) -- 360, 175
	if cronometro.cronometro1 == false then
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
	love.graphics.print("Expressions", 725, 3)
	love.graphics.rectangle("line", 725, 45, 170, 45)

	love.graphics.setFont(pixel75)
	love.graphics.print(player.score, 727, 35)

	love.graphics.setFont(pixel46)
	love.graphics.print("Awnser: ", 355, 400)

end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end