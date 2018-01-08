function ponteando(leftResult, rightResult, resposta)

	flag1 = (leftResult > rightResult)
	flag2 = (leftResult >= rightResult)
	flag3 = (leftResult < rightResult)
	flag4 = (leftResult <= rightResult)
	
	finalFlag = false
	if resposta == ">" then
		finalFlag = flag1
	elseif resposta == ">=" then
		finalFlag = flag2
	elseif resposta == "<" then
		finalFlag = flag3 
	elseif resposta == "<=" then
		finalFlag = flag4
	end

	return finalFlag
end