function onCreatePost()
	
	makeLuaSprite('popup', 'songcreds/transcendent', -950, 500)
	addLuaSprite('popup') 
	setObjectCamera('popup', 'game')
	
	setProperty('camHUD.visible', false);
	
	noteTweenX("NoteMove1", 4, 50, 0.5, cubeInOut) -- bf notes in order
	noteTweenX("NoteMove3", 5, 160, 0.5, cubeInOut)
	noteTweenX("NoteMove4", 6, 270, 0.5, cubeInOut)
	noteTweenX("NoteMove2", 7, 380, 0.5, cubeInOut)

	noteTweenX("NoteMove5", 0, 720, 0.5, cubeInOut) -- dad notes in order
	noteTweenX("NoteMove6", 1, 830, 0.5, cubeInOut)
	noteTweenX("NoteMove7", 2, 940, 0.5, cubeInOut)
	noteTweenX("NoteMove8", 3, 1050, 0.5, cubeInOut)

	end

function onStepHit()
	
	if curStep == 60 then
		setProperty('camHUD.visible', true);
	end

	if curStep == 3 then
		doTweenX('popupxtween', 'popup', 260, 1, 'backInOut')
	end
	if curStep == 31 then
		doTweenX('popupxtween2', 'popup', -1000, 2.9, 'backOut')
	end

	if curStep == 95 then
		removeLuaSprite('popup')	
	end	

	if curStep == 191 then
		setProperty('defaultCamZoom', 0.55);
	end
	
end