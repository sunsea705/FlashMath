local suit = require 'functions/suit'

require 'menus/training_rooms'
require 'menus/basic_controls'
require 'menus/about_game'

function instructionMenu_load()
	str_b = "Hover over the button to see a brief description of what it does."
	str = ""

	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46)
	pixel56 = love.graphics.newFont("fonts/pixel.ttf", 56)

	controlpad = love.graphics.newImage("images/gamepad40.png")
	strategy = love.graphics.newImage("images/strategy40.png")
	light = love.graphics.newImage("images/light40.png")
	exitE = love.graphics.newImage("images/exit40.png")
	background = love.graphics.newImage("images/back1.png")
	
	posXis, imageWidth = 0, background:getWidth()

	posX = 300
	larX = 270

end

function instructionMenu_update(dt)
	
	posXis = posXis - 1
	-- SUIT: Verificando se o mouse está na área do botão, através de .hovered
	if btn1.hovered then 
		str = "See the basic instructions about the game."
	elseif btn2.hovered then
		str = "Learn to be the best player of the game, with tatics and strategies."
	elseif btn3.hovered then
		str = "See information about the development of the game and its author."
	elseif btn4.hovered then
		str = "Return to main menu."
	else
		str = ""
	end

	-- SUIT: Chamando os sub-menus através do clique do mouse pelo .hit
	if btn1.hit then
		basicControls()
	end
	if btn2.hit then
		trainingRooms()
	end
	if btn3.hit then
		aboutGame()
	end
	if btn4.hit then
		startscreen()
	end
	
end

function instructionMenu_draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(background, posXis, 0) -- this is the original image
    love.graphics.draw(background, posXis + imageWidth, 0)

	if posXis <= -imageWidth then
		posXis = 0
	end
	
	love.graphics.setFont(pixel56)
	love.graphics.print("Welcome to Instructions Menu!", 220, 15)
	
	love.graphics.setFont(pixel46)
	love.graphics.print(str_b, 45, 50)
	love.graphics.print(str, 25, 380)

	btn1 = suit.Button("Basic Controls", posX, 100, larX,40)
	love.graphics.draw(controlpad, 580, 100)
	btn2 = suit.Button("Training Rooms", posX, 160, larX,40)
	love.graphics.draw(strategy, 580, 160)
	btn3 = suit.Button("About The Game", posX, 220, larX,40)
	love.graphics.draw(light, 580, 220)
	btn4 = suit.Button("Back To Main Menu", posX, 280 , larX,40)
	love.graphics.draw(exitE, 580, 280)

	love.graphics.print("Brief description", 30, 345)
	love.graphics.rectangle("line", 25, 350, 215, 30)
	love.graphics.rectangle("line", 20 ,380, 860, 100)

	suit.draw() -- desenha na tela os elementos anteriores que são formados pelo suit

end

function startscreen()
	gamestate = "startscreen"
	startscreen_load()
end

function trainingRooms()
	gamestate = "trainingRooms"
	trainingRooms_load()
end

function basicControls()
	gamestate = "basicControls"
	basicControls_load()
end

function aboutGame()
	gamestate = "aboutGame"
	aboutGame_load()
end
