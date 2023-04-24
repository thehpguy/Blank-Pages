function onCreatePost()
	
	makeLuaSprite('popup', 'songcreds/chuck', -950, 100)
	addLuaSprite('popup') 
	setObjectCamera('popup', 'hud')
	setProperty("popup.scale.x", 0.6);
	setProperty("popup.scale.y", 0.6);
end

function onStepHit()

	if curStep == 3 then
		doTweenX('popupxtween', 'popup', 370, 1, 'backInOut')
	end
	if curStep == 31 then
		doTweenX('popupxtween2', 'popup', -1300, 2.9, 'backOut')
	end

	if curStep == 95 then
		removeLuaSprite('popup')	
	end	
	
end