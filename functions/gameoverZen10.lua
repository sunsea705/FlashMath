function gameoverZen10()
	gameover = {}
	for coluna = 1, 5 do
		gameover[coluna] = {}
		for linha = 1, 4 do
			gameover[coluna][linha] = ""
		end
	end
	
	--gameover[coluna][linha]
	gameover[1][1] = "G"
	gameover[2][1] = "A"
	gameover[3][1] = "M"
	gameover[4][1] = "E"
	gameover[1][2] = "O"
	gameover[2][2] = "V"
	gameover[3][2] = "E"
	gameover[4][2] = "R"
	gameover[5][1] = "!"
	gameover[5][2] = "!"
	
	gameover[1][3] = "G"
	gameover[2][3] = "A"
	gameover[3][3] = "M"
	gameover[4][3] = "E"
	gameover[1][4] = "O"
	gameover[2][4] = "V"
	gameover[3][4] = "E"
	gameover[4][4] = "R"
	gameover[5][3] = "!"
	gameover[5][4] = "!"
	
	return gameover
	
end
	