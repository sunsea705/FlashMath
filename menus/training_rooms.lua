local suit = require 'functions/suit'


function trainingRooms_load()

	myFont46 = love.graphics.newFont("fonts/pixel.ttf", 46)
	myFont75 = love.graphics.newFont("fonts/pixel.ttf", 56)
	

	box = love.graphics.newImage("images/box.png")
	background = love.graphics.newImage("images/back1.png")

	posX = 100
	larX = 365

end


function trainingRooms_update(dt)
	
	if btn1.hit then
		instructionMenu()
	end
	
	if btn2.hit then
		startscreen()
	end
	
end

function trainingRooms_draw()

	love.graphics.draw(background)
	
	love.graphics.setFont(myFont75)
	love.graphics.draw(box, 300, 100)
	love.graphics.print("Collect 7 achievements to unlock this option!", 150, 200)
	
	love.graphics.setFont(myFont46)
	btn1 = suit.Button("Back To Instructions Menu", 70, 400, larX,40)
	btn2 = suit.Button("Back To Main Menu", 470, 400 , larX,40)
	
	suit.draw() -- desenha na tela os elementos anteriores que são formados pelo suit

end

function startscreen()
	gamestate = "startscreen"
	startscreen_load()
end

function instructionMenu()
	gamestate = "instructionMenu"
	instructionMenu_load()
end