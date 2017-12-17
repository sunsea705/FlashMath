local suit = require 'functions/suit'

function aboutGame_load()

	background = love.graphics.newImage("images/back1.png")
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46)
	pixel56 = love.graphics.newFont("fonts/pixel.ttf", 56)
	
	-- LOAD REFERENTE AO BACKGROUND E SUA MOVIMENTAȃO
	background = love.graphics.newImage("images/back1.png")
	posX = 0
	imageWidth = background:getWidth()
	str1 = 'FlashMath is a game made in framework tool LÖVE2D with the language\n'
	str2 = 'programming Lua. Made of by Ítalo Tiago for "chair" of Algoritmos I,\n'
	str3 = 'to professor Carlos Salles de Neto. Enjoy!\n'
	
	str4 = 'Special thanks for Kaio, Daniel and Fernando, what helped me a lot of\n'
	str5 = 'far in development of game with clues in codes and ideas for the\n'
	str6 = 'mechanics present in game.\n'
	str7 = 'Another special thank for my girlfriend, Mayra, what always helped me \n'
	str8 = 'with encouragement in the most difficult hours. I LÖVE YOU!'
	
end

function aboutGame_update(dt)
	-- VELOCIDADE DA MOVIMENTAȃO DO BACKGROUND
	posX = posX - 1
	
	if btn1.hit then
		instructionMenu()
	end
	
	if btn2.hit then
		startscreen()
	end
	
end

function aboutGame_draw()
	-- DESENHANDO O BACKGROUND ANIMADO
	love.graphics.draw(background, posX, 0) 
    love.graphics.draw(background, posX + imageWidth, 0)

	if posX <= -imageWidth then
		posX = 0
	end
	
	love.graphics.setFont(pixel46)
	
	love.graphics.print(str1 .. str2 .. str3, 20, 70)
	love.graphics.print(str4 .. str5 .. str6 .. str7 .. str8, 20, 185)
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