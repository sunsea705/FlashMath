require "menus/startscreen"

function love.load()
	gamestate = "startscreen"
	startscreen_load()
end

function love.update(dt)
	if gamestate == "startscreen" then
		startscreen_update(dt)
	elseif gamestate == "select_mode" then
		selectMode_update(dt)
	elseif gamestate == "Precision_menu" then
		PrecisionMenu_update(dt)
	elseif gamestate == "Wisdom_menu" then
		WisdomMenu_update(dt)
	elseif gamestate == "Wisdom_Arcade" then
		WisdomArcade_update(dt)
	elseif gamestate == "Wisdom_TimeAttack" then
		WisdomTimeAttack_update(dt)
	elseif gamestate == "Wisdom_TheBridge" then
		WisdomTheBridge_update(dt)
	elseif gamestate == "Precision_Arcade" then
		Precision_Arcade_update(dt)
	elseif gamestate == "Precision_TimeAttack" then
		Precision_TimeAttack_update(dt)
	elseif gamestate == "Precision_Zen10" then
		Precision_Zen10_update(dt)
	elseif gamestate == "instructionMenu" then
		instructionMenu_update(dt)
	elseif gamestate == "trainingRooms" then
		trainingRooms_update(dt)
	elseif gamestate == "basicControls" then
		basicControls_update(dt)
	elseif gamestate == "aboutGame" then
		aboutGame_update(dt)
	end
end

function love.draw()
	if gamestate == "startscreen" then
		startscreen_draw()
	elseif gamestate == "select_mode" then
		selectMode_draw()
	elseif gamestate == "Precision_Arcade" then
		Precision_Arcade_draw()
	elseif gamestate == "Precision_TimeAttack" then
		Precision_TimeAttack_draw()
	elseif gamestate == "Precision_Zen10" then
		Precision_Zen10_draw()
	elseif gamestate == "Precision_menu" then
		PrecisionMenu_draw()
	elseif gamestate == "Wisdom_menu" then
		WisdomMenu_draw()
	elseif gamestate == "Wisdom_Arcade" then
		WisdomArcade_draw()
	elseif gamestate == "Wisdom_TimeAttack" then
		WisdomTimeAttack_draw()
	elseif gamestate == "Wisdom_TheBridge" then
		WisdomTheBridge_draw()
	elseif gamestate == "instructionMenu" then
		instructionMenu_draw()
	elseif gamestate == "trainingRooms" then
		trainingRooms_draw()
	elseif gamestate == "basicControls" then
		basicControls_draw()
	elseif gamestate == "aboutGame" then
		aboutGame_draw()
	end
end
