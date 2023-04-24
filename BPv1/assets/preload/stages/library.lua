function onCreate()
	
	makeLuaSprite('book', 'close-chuck/library', -700, 0);
	setScrollFactor('book', 0.9, 0.9);
	addLuaSprite('book', false);
	setObjectOrder('book', 1)
	setObjectOrder('gfGroup', 2)
	setObjectOrder('bfGroup', 3)
	setObjectOrder('dadGroup', 4)
    
    makeLuaSprite('bartop','',0,-130)
    makeGraphic('bartop',1280,100,'000000')

    addLuaSprite('bartop',true)
    setObjectCamera('bartop','game')
    setScrollFactor('bartop',0,0)
	setProperty("bartop.scale.x", 1.5);
	setProperty("bartop.scale.y", 1.5);
	setObjectOrder('bartop', 5)


    makeLuaSprite('barbot','',0,760)
    makeGraphic('barbot',1280,100,'000000')
    addLuaSprite('barbot',true)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','game')
	setProperty("barbot.scale.x", 1.5);
	setProperty("barbot.scale.y", 1.5);
	setObjectOrder('barbot', 6)
end

local spin = 2
function onUpdate(elasped)
	if curStep >= 0 and curStep < 5000 then
	local songPos = getPropertyFromClass('Conductor', 'songPosition') / 1000 --How long it will take.
		setProperty("camHUD.angle", spin * math.sin(songPos))
	end
	if curStep >= 5000 then
        setProperty("camHUD.angle", 0)
   	end
end
	