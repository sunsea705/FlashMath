local suit = require 'functions/suit'

require "menus/instruction_menu"
require "menus/select_mode"

-- T√çTULO DOS BOT√ïES/CAIXA DE DIALOG BOX
local title = "Exit?"
local message = "Do you really want to exit?"
local buttons = {"Yes", "No", escapebutton = 2}

function startscreen_load()
	
	respostaInput = {text = "", keyEnter = false} -- SEM COMENT√ÅRIOS

	-- LOAD REFERENTE AS FONTES
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46) -- setando o tamanho da fonte para 46, quando for chamada, seta para 25
	pixel50 = love.graphics.newFont("fonts/digital.ttf",50)
	pixel100 = love.graphics.newFont("fonts/pixel.ttf", 175)	-- setando o tamanho da fonte para 50,  mesma coisa

	-- LOAD REFERENTE AO BACKGROUND E SUA MOVIMENTA«√O
	background = love.graphics.newImage("images/back1.png")
	posX = 0
	imageWidth = background:getWidth()

end

function startscreen_update(dt)

	-- VELOCIDADE DA MOVIMENTA«√O DO BACKGROUND
	posX = posX - 1

	-- SUIT: Criando os bot√µes e verificando se foram clicados
	if suit.Button("Start Game", 110, 400, 225,40).hit then
	   select_mode()
    end
	if suit.Button("Instructions", 355, 400, 225,40).hit then
		instructionMenu()
	end
	if suit.Button("Quit Game", 600, 400, 225,40).hit then
		local pressedbutton = love.window.showMessageBox(title, message, buttons, info, false)
		if pressedbutton == 1 then
			love.event.quit()
		end
	end
end

function startscreen_draw()
	-- DESENHANDO O BACKGROUND ANIMADO
	love.graphics.draw(background, posX, 0) 
    love.graphics.draw(background, posX + imageWidth, 0)

	if posX <= -imageWidth then
		posX = 0
	end
	
		-- T√çTULO DO JOGO 
	love.graphics.setFont(pixel100)
	love.graphics.print("FlashMath", 225, 100)
	
	love.graphics.setFont(pixel46)
	suit.draw() -- desenha na tela os elementos anteriores que s√£o formados pelo suit

end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end

function instructionMenu()
	gamestate = "instructionMenu"
	instructionMenu_load()
end