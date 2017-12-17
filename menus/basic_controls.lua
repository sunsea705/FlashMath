local suit = require 'functions/suit'

function basicControls_load()

	background = love.graphics.newImage("images/back1.png")
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46)
	pixel30 = love.graphics.newFont("fonts/pixel.ttf", 30)
	pixel56 = love.graphics.newFont("fonts/pixel.ttf", 56)
	
	posX, imageWidth = 0, background:getWidth()

	t1 = "It's very simple: In first time, move the mouse cursor for the grey text box, and digit your answer what\n" 
	t2 = 'you think what be correct, so click in "Enter/Return" button to validate your answer. The game works\n'
	t3 = 'as much as "Enter/Return" of numeric keyboard or "Enter/Return" of text/symbol keyboard. Click on\n'
	t4 = '"Reset Game" to reset your lives, score and expression or in "Back To Main Menu" to end the game.'
	
	t5 = "The objective of the game is you to hit maximum possible mathematics expressions to make your score\n"
	t6 = 'to be a maximum possible too, as you can, until your lives is gone. You have 15 seconds to answer\n' 
	t7 = 'each question, and if you miss the answer or the countdown reaches to 0, you lose a life. You start\n'
	t8 = 'with 3 lives. If your lives reach to 0, you lose the game.'
	
	t9 = 'Be smart during your game, because even if the expressions are easy in the beginning, as you hit them,\n'
   t10 = 'they will become more difficult without you realizing it. To make high scores, you must respond to the\n'
   t11 = 'expressions as quickly as possible, as your score is given by the response time of each expression.'
	
end

function basicControls_update(dt)

	posX = posX - 1
	
	if btn1.hit then
		instructionMenu()
	end
	
	if btn2.hit then
		startscreen()
	end
end

function basicControls_draw()
	love.graphics.setColor(255,255,255)
	
	love.graphics.draw(background, posX, 0) 
    love.graphics.draw(background, posX + imageWidth, 0)

	if posX <= -imageWidth then
		posX = 0
	end
	
	love.graphics.setFont(pixel56)
	love.graphics.setColor(1,1,1)
	
	love.graphics.print("How to Play", 350, 20)
	love.graphics.print("Rules/Objectives", 320, 170)
	love.graphics.print("Difficulty/Scoring", 310, 320)
	
	love.graphics.setFont(pixel30)
	love.graphics.print(t1 .. t2 .. t3 .. t4, 20, 70)
	love.graphics.print(t5 .. t6 .. t7 .. t8, 20, 220)
	love.graphics.print(t9 .. t10 .. t11, 20, 370)
	
	love.graphics.setFont(pixel46)
	btn1 = suit.Button("Back To Instructions Menu", 70, 450, 365, 40 )
	btn2 = suit.Button("Back To Main Menu", 470, 450, 365, 40 )
	suit.draw()
end

function startscreen()
	gamestate = "startscreen"
	startscreen_load()
end

function instructionMenu()
	gamestate = "instructionMenu"
	instructionMenu_load()
end