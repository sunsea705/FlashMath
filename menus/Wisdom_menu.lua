local suit = require 'functions/suit'

require "game_modes/Wisdom_Arcade"
require "game_modes/Wisdom_TimeAttack"

require "functions/retangulando"

function WisdomMenu_load()

	stringue = ""
	str1 = "In each expression,\nyour objective is check\nif expression result\nis true or false.\nYou have three lives\nto get the biggest\nscore."
	str2 = "You have ONLY A LIVE,\nand your objective is\nsolves the biggest \nnumber of corrects\nexpressions under the \ntime of 1min30sec."
	--str3 = "In a lot of expressions,\nyour job is find\nwhat operator makes\nthe expression be correct.\nHurry up, because\nthe time is short."
	
	retX = 5
	--ret1Y, ret2Y, ret3Y = 80, 190, 300
	ret1Y, ret2Y = 80, 190
	larR = 550
	altR = 100
	
	mouseX = 0
	mouseY = 0
	
	-- LOAD REFERENTE AS FONTES
	pixel46 = love.graphics.newFont("fonts/pixel.ttf", 46) -- setando o tamanho da fonte para 46, quando for chamada, seta para 25
	pixel56 = love.graphics.newFont("fonts/pixel.ttf", 66)
	pixel100 = love.graphics.newFont("fonts/pixel.ttf", 100)	-- setando o tamanho da fonte para 50,  mesma coisa

	-- LOAD REFERENTE AO BACKGROUND E SUA MOVIMENTAȃO
	back = love.graphics.newImage("images/newBlue.png")
	background = back
	posX, imageWidth = 0, background:getWidth()
	arcade = love.graphics.newImage("images/arcade.png")
	timeAttack = love.graphics.newImage("images/timeattack.png")
	--bridge = love.graphics.newImage("images/bridge.png")
	
end

function WisdomMenu_update(dt)

	mouseX, mouseY = love.mouse.getPosition()
	posX = posX - 1
	
	-- CHAMANDO OS MENUS ATRAVÉS DO BOTÕES DO SUIT
	if btn1.hit then
		startscreen()
	end
	
	if btn2.hit then
		select_mode()
	end
	
	if play1.hit then
		Wisdom_Arcade()
	end
	
	if play2.hit then
		Wisdom_TimeAttack()
	end
	
	--[[if play3.hit then
		ual = true
	end]]--
	
	-- MUDANDO O BACKGROUND E O TEXTO DE DESCRIÇÃO DEPENDENDO DE ONDE O MOUSE ESTÁ 
	if retangulando(mouseX, mouseY, retX, ret1Y, larR, altR) then
		stringue = str1
	elseif retangulando(mouseX, mouseY, retX, ret2Y, larR, altR) then
		stringue = str2
	--[[elseif retangulando(mouseX, mouseY, retX, ret3Y, larR, altR) then
		stringue = str3
	]]--
	else
		stringue = ""
	end
	
end

function WisdomMenu_draw()
	love.graphics.setColor(255,255,255)
	
	love.graphics.draw(background, posX, 0) 
    love.graphics.draw(background, posX + imageWidth, 0)

    if posX <= -imageWidth then
		posX = 0
	end
	
	love.graphics.setFont(pixel56)
	love.graphics.print("Select a mode to play!", 275, 9)
	
	love.graphics.setFont(pixel100)
	love.graphics.rectangle('line', retX, ret1Y, larR, altR)
	love.graphics.print('Arcade', 80, 85)
	love.graphics.draw(arcade, 10, 95)
	
	love.graphics.rectangle('line', retX, ret2Y, larR, altR)
	love.graphics.print('Time Attack', 80, 195)
	love.graphics.draw(timeAttack, 10, 205)
	
	--[[love.graphics.rectangle('line', retX, ret3Y, larR, altR)
	love.graphics.print('The Bridge', 80, 305)
	love.graphics.draw(bridge, 10, 315)]]--
	
	love.graphics.setFont(pixel46)
	love.graphics.rectangle('line', 657, 50, 145, 30)
	love.graphics.print('About Mode', 660, 48)
	
	love.graphics.rectangle('line', 575, ret1Y, 310, 320)
	love.graphics.print(stringue, 580, 75)
	
	btn1 = suit.Button("Back To Main Menu", 70, 450, 365, 40 )
	btn2 = suit.Button("Back To Select Mode", 470, 450, 365, 40 )
	
	play1 = suit.Button("Play!", 490, 140, 65, 40)
	play2 = suit.Button("Play! ", 490, 250, 65, 40)
	--play3 = suit.Button("Play!  ", 490, 360, 65, 40)
	
	suit.draw()
	
end

function startscreen()
	gamestate = "startscreen"
	startscreen_load()
end

function select_mode()
	gamestate = "select_mode"
	selectMode_load()
end

function Wisdom_Arcade()
	gamestate = "Wisdom_Arcade"
	WisdomArcade_load()
end

function Wisdom_TimeAttack()
	gamestate = "Wisdom_TimeAttack"
	WisdomTimeAttack_load()
end