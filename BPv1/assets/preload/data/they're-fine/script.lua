function onCreatePost()
	
	makeLuaSprite('popup', 'songcreds/fine', -950, 100)
	addLuaSprite('popup') 
	setObjectCamera('popup', 'hud')
end

function onStepHit()

	if curStep == 3 then
		doTweenX('popupxtween', 'popup', 385, 1, 'backInOut')
	end
	if curStep == 31 then
		doTweenX('popupxtween2', 'popup', -1000, 2.9, 'backOut')
	end

	if curStep == 95 then
		removeLuaSprite('popup')	
	end	
	
end