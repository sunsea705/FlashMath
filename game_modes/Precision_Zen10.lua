local suit = require "functions/suit"
require "functions/numerando"
require "functions/dificulteando"
require "functions/level_up"
require "functions/operacionando"
require "functions/paranteseando"
require "functions/retangulando"
require "functions/zenando"
require "functions/gameoverZen10"

function Precision_Zen10_load()
	-- LOAD REFERENTE AO CRONÔMETRO (coloque 1 segundo a mais que o tempo especificado)
	cronometro = {
		remaining_time = 16,
		time_backup = 16, 
		stopwatch = 0,
		ending = false
	}
	
	-- LOAD REFERENTE A FONTE
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46)
	pixel75 = love.graphics.newFont("fonts/pixel.ttf", 75)
	pixel55 = love.graphics.newFont("fonts/pixel.ttf", 55)
	pixel32 = love.graphics.newFont("fonts/pixel.ttf", 32)
	digital50 = love.graphics.newFont("fonts/digital.ttf",45)

	-- LOAD REFERENTE AS IMAGENS
	background = love.graphics.newImage("images/newRed.png")
	posX, imageWidth = 0, background:getWidth()
	clockI = love.graphics.newImage("images/clock.png")
	life = love.graphics.newImage("images/heart.png")
	lifeH = love.graphics.newImage("images/heartbreak.png")

	-- LOAD REFERENTE AO PLAYER E SUAS INFORMAÇÕES IN GAME
	player = {
		lifes = 3,
		score = 0,
		expCount = 0 -- XP: quantidade de acertos do jogador
	}

	currentLevel = 1 -- nivel atual (faixa de dificuldade)
	int1, int2, int3 = 0, 10, 2 -- faixa de intervalos para a geração de números aleatórios (inicialmente)

	-- LOAD REFERENTE AS POSIÇÕES DE CADA RETÂNGULO E DAS EXPRESSÕES CONTIDAS EM CADA UM
	positions = {} -- matriz que vai guardar cada uma das posições X e Y do retângulo (melhor do que 20 variáveis)
	expressions = zenando(int1, int2, int3) -- expressions é outra matriz, 5 x 4 contendo as 20 expressões
	mousePress = false -- flag do pressionamento do mouse
	gameover = false

end

function love.mousepressed(x, y, button) -- checando se o botão 1 do mouse foi pressionado, mudando a flag do click pra true (coisa que já vimos nos outros modos)
	if button == 1 then
		mousePress = true
	end
end

function love.mousereleased(x, y, button) -- checando se o botão 1 foi solto. Ou seja, pro usuário validar a resposta ele deve clicar realmente
	if button == 1 then
		mousePress = false
	end
end

function Precision_Zen10_update(dt)
	-- VELOCIDADE DA MOVIMENTAÇÃO DO BACKGROUND
	posX = posX - 1
	
	-- CRONÔMETRO: Essa parte faz o cronômetro descrecer e atualizar seu valor
	if cronometro.ending == false then -- se o 'stop' do cronometro estiver off, ele deve descrecer o tempo
		cronometro.remaining_time = cronometro.remaining_time - dt
		cronometro.stopwatch = math.floor(cronometro.remaining_time)
		if cronometro.stopwatch < 0 then
			player.lifes = player.lifes - 1
			cronometro.remaining_time = cronometro.time_backup
		end
	else -- senão, ele deve zerar o cronometro
		cronometro.stopwatch = 0
	end
	
	
	-- PEGANDO AS POSIÇÕES DO MOUSE EM TEMPO REAL
	mouseX, mouseY = love.mouse.getPosition()

	-- AUMENTANDO O NÍVEL BASEADO NO NÚMERO DE EXPRESSÕES DO JOGADOR
	currentLevel = level_up(player.expCount) -- muda o nível atual do jogo através da função level_up(), que usa os XP do jogador para tal
	int1, int2, int3 = dificulteando(currentLevel) -- muda a faixa de números, baseado no nível atual, através da função dificulteando()

	-- BOTÃO PARA RETORNAR AO MENU INICIAL  Org: 495, 20, 250, 40
	if btnMenu.hit then
		select_mode()
	end

	-- BOTÃO PARA INICIAR O JOGO
	if btnReset.hit then
		int1, int2, int3 = 0, 10, 2
		player.lifes, player.score, player.expCount = 3, 0, 0 -- resetando os dados do player
		cronometro.ending, cronometro.remaining_time = false, cronometro.time_backup -- resetando cronometro
		currentLevel = 1 -- voltando a primeira fase
		mousePress = false -- desligando o mouse
		gameover = false
		expressions = zenando(int1, int2, int3) -- gerando uma nova matriz de expressões
	end

end

function Precision_Zen10_draw()
	-- DESENHANDO O BACKGROUND ANIMADO (SEMPRE COLOCAR PRIMEIRO)
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
		if player.lifes <= 1 then -- e em conse,quencia a segunda
			l2 = lifeH
		end
		if player.lifes == 0 then -- e por fim, a última
			l1 = lifeH
		end
	end

	love.graphics.draw(l1, 90, 30)
	love.graphics.draw(l2, 124, 30)
	love.graphics.draw(l3, 158, 30)
	
	-- SUIT: DESENHANDO OS BOTÕES E A CAIXA DE TEXTO
	love.graphics.setFont(pixel46)
	love.graphics.print("Lives: " , 20, 20 )
	btnMenu = suit.Button("Back To Select Mode ", 425, 450, 365, 40)
	btnReset = suit.Button("Reset Game", 150, 450, 250, 40 )
	suit.draw()
	
	-- DESENHANDO E ATUALIZANDO O CRONÔMETRO DA TELA (e um reloginho)
	love.graphics.setFont(digital50)
	love.graphics.draw(clockI, 350, 40)
	
	if cronometro.stopwatch >= 10 then 
		love.graphics.print("0:".. cronometro.stopwatch, 390,50) -- 0:15
	else
		love.graphics.print("0:0".. cronometro.stopwatch, 390,50) -- 0:09
	end

	-- DESENHANDO OS 20 RETÂNGULOS NA TELA E IMPRIMINDO AS EXPRESSÕES EM CADA RETÂNGULO E GUARDANDO SUAS POSIÇÕES NA MATRIZ positions
	tamX, tamY = 175, 70
	rX = -tamX + 15

	love.graphics.setFont(digital50)
	for i = 1, 5 do
		rX, rY = rX + tamX, 30
		positions[i] = {}
		for j = 1, 4 do
			rY = rY + tamY
			love.graphics.rectangle('line', rX, rY, tamX, tamY)
			if gameover then
				gameoverPrint = gameoverZen10()
				love.graphics.print(gameoverPrint[i][j], rX + 5, rY + 30)
			else
				love.graphics.print(expressions[i][j].printi, rX + 5, rY + 30)
			end
			positions[i][j] = {retX = rX, retY = rY - 20, larR = 175, altR = 70} -- sim. Uma matriz de tabela.
		end
	end
	
	-- ALMA DO JOGO: VERIFICANDO SE O USUÁRIO CLICOU EM ALGUM DOS 20 RETÂNGULOS E SE FOI O RETÂNGULO CUJA EXPRESSÃO É IGUAL A 10
	if player.lifes > 0 then
		for i = 1, 5 do
			for j = 1, 4 do
				if retangulando(mouseX, mouseY, positions[i][j].retX, positions[i][j].retY, positions[i][j].larR, positions[i][j].altR) and mousePress then
					if expressions[i][j].result == 10 then
						player.score = player.score + cronometro.stopwatch
						player.expCount = player.expCount + 1
					else
						player.lifes = player.lifes - 1	
					end
				-- GERANDO NOVOS RETâNGULOS COM NOVAS EXPRESSÕES
				expressions = zenando(int1, int2, int3)
				mousePress = false
				cronometro.remaining_time = cronometro.time_backup
				end
			end
		end
	else
		gameover = true
		cronometro.ending = true
	end

	-- MOSTRANDO OUTROS ELEMENTOS NA TELA
	love.graphics.setFont(pixel55)
	love.graphics.print("Score ", 770, 3)
	love.graphics.rectangle("line", 740, 45, 150, 45) -- retângulo do score
	love.graphics.setFont(pixel75)
	love.graphics.print(player.score, 743, 35) -- mostrando o score

end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end
























--[[ TESTING AREA --
love.graphics.setFont(pixel32)
	love.graphics.print("MX: " .. mouseX .. "\nMY: " .. mouseY, 400, 50)
	love.graphics.print("Ret X: " .. positions[1][1].retX .. " Ret Y:" .. positions[1][1].retY ..
	" Lar R: " .. positions[1][1].larR .. " Alt R: " .. positions[1][1].altR, 100, 30)

	if retangulando(mouseX, mouseY, positions[1][1].retX, positions[1][1].retY, positions[1][1].larR, positions[1][1].altR) and mousePress then
		love.graphics.print("UIIIIII", 500, 30)
	end
	if retangulando(mouseX, mouseY, positions[1][2].retX, positions[1][2].retY, positions[1][2].larR, positions[1][2].altR) then
		love.graphics.print("UIIIIII", 500, 30)
	end
]]--