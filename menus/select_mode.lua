local suit = require 'functions/suit'
require "functions/retangulando"

require "menus/Precision_menu"
require "menus/Wisdom_menu"

function selectMode_load()

	str, stringue = "", "" 
	str1 = "Test your power of mind\ncalc solving various\naritmetical expressions\nThat will be more harder \nas time goes on."
	str2 = "Use your logic power to\nsolving problems what\nevolves know if it's\ntrue or false, using\nbasic prongramming\nconcepts."
	--str3 = "Forces your head and\ncreate a brainstorm to\nsolves a various types\nof mathematicals seque-\nnces."

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
	back = love.graphics.newImage("images/back1.png")
	background = back
	posX, imageWidth = 0, background:getWidth()
	red = love.graphics.newImage("images/newRed.png")
	blue = love.graphics.newImage("images/newBlue.png")
	--green = love.graphics.newImage("images/newGreen.png")
	precision = love.graphics.newImage("images/precision.png")
	wisdom = love.graphics.newImage("images/wisdom.png")
	--endurance = love.graphics.newImage("images/endurance.png")

end

function selectMode_update(dt)

	mouseX, mouseY = love.mouse.getPosition()
	posX = posX - 1

	if btn.hit then
		startscreen()
	end

	if play1.hit then
		Precision_Menu()
	end

	if play2.hit then
		Wisdom_Menu()
	end

	--[[if play3.hit then
		ual = true
	end
	]]--

	-- MUDANDO O BACKGROUND E A DESCRIÇÃO DEPENDENDO DE ONDE O MOUSE ESTÁ
	if retangulando(mouseX, mouseY, retX, ret1Y, larR, altR) then
		stringue = str1
		background = red
	elseif retangulando(mouseX, mouseY, retX, ret2Y, larR, altR) then
		stringue = str2
		background = blue
	--[[elseif retangulando(mouseX, mouseY, retX, ret3Y, larR, altR) then
		stringue = str3
		background = green
	]]--
	else
		stringue = ""
		background = back
	end

end

function selectMode_draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(background, posX, 0) 
    love.graphics.draw(background, posX + imageWidth, 0)

	if posX <= -imageWidth then
		posX = 0
	end

	love.graphics.setFont(pixel56)
	--love.graphics.setColor(1,1,1)
	love.graphics.print("Select a mode to play!", 275, 9)

	love.graphics.setFont(pixel100)
	love.graphics.rectangle('line', retX, ret1Y, larR, altR)
	love.graphics.print('Precision', 80, 85)
	love.graphics.draw(precision, 10, 95)
	
	love.graphics.rectangle('line', retX, ret2Y, larR, altR)
	love.graphics.print('Wisdom', 80, 195)
	love.graphics.draw(wisdom, 10, 205)
	
	--[[love.graphics.rectangle('line', retX, ret3Y, larR, altR)
	love.graphics.print('Endurance', 80, 305)
	love.graphics.draw(endurance, 10, 315)]]--

	love.graphics.setFont(pixel46)
	love.graphics.rectangle('line', 657, 50, 145, 30)
	love.graphics.print('About Mode', 660, 48)
	
	love.graphics.rectangle('line', 575, ret1Y, 310, 320)
	love.graphics.print(stringue, 580, 75)

	btn = suit.Button("Back To Main Menu", 300, 450 , 270 ,40)
	play1 = suit.Button("Play!", 490, 140, 65, 40)
	play2 = suit.Button("Play! ", 490, 250, 65, 40)
	--play3 = suit.Button("Play!  ", 490, 360, 65, 40)
	
	suit.draw()

end

function startscreen()
	gamestate = "startscreen"
	startscreen_load()
end

function Precision_Menu()
	gamestate = "Precision_menu"
	PrecisionMenu_load()
end

function Wisdom_Menu()
	gamestate = "Wisdom_menu"
	WisdomMenu_load()
end