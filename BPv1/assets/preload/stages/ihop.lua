beatSide = 0;
function onCreate()
	-- background shit
	setProperty('defaultCamZoom',0.75)

	setObjectOrder('gfGroup', 3)
	setObjectOrder('dadGroup', 2)
	setObjectOrder('bfGroup', 1)

    	makeLuaSprite('bartop','',0,-30)
    	makeGraphic('bartop',1280,100,'000000')
    	addLuaSprite('bartop',true)
    	setObjectCamera('bartop','hud')
    	setScrollFactor('bartop',0,0)

    	makeLuaSprite('barbot','',0,650)
    	makeGraphic('barbot',1280,100,'000000')
    	addLuaSprite('barbot',true)
   	setScrollFactor('barbot',0,0)
    	setObjectCamera('barbot','hud')
	makeLuaSprite('sky', 'cutesy-date/sky', -700, 0);
	addLuaSprite('sky', false);

	if not lowQuality then
		makeAnimatedLuaSprite('unoart', 'cutesy-date/unoart', -1050, 40);
		addAnimationByPrefix('unoart', 'idle1', 'bothdance', 15, true);
		addAnimationByPrefix('unoart', 'leave', 'artleave', 13, true);
		addAnimationByPrefix('unoart', 'idle2', 'unodance', 10, true);
		addAnimationByPrefix('unoart', 'shock', 'unoshock', 8, true);
		setProperty("unoart.scale.x", 0.4);
		setProperty("unoart.scale.y", 0.4);
		addLuaSprite('unoart', false);
	end
	
	makeLuaSprite('bg', 'cutesy-date/bg', -700, 0);
	addLuaSprite('bg', false);

	if not lowQuality then
		makeAnimatedLuaSprite('left', 'cutesy-date/bg boop Left', -575, 310);
		addAnimationByPrefix('left', 'idle', 'bg BOPING left instancia', 24, true);
		setProperty("left.scale.x", 0.9);
		setProperty("left.scale.y", 0.9);
		addLuaSprite('left', false);
	
		makeAnimatedLuaSprite('right', 'cutesy-date/bg Boop Right', 540, 360);
		addAnimationByPrefix('right', 'idle', 'bg BOOP right instancia', 24, true);
		setProperty("right.scale.x", 0.9);
		setProperty("right.scale.y", 0.9);
		addLuaSprite('right', false);
	end
	
	makeLuaSprite('booth', 'cutesy-date/booth', -700, 0);
	addLuaSprite('booth', false);
	
	makeLuaSprite('tableau', 'cutesy-date/tableau', -700, 0);
	addLuaSprite('tableau', false);
	objectPlayAnimation('unoart', 'idle1', false);
end

function onStepHit()
	if curStep == 784 then
		objectPlayAnimation('unoart', 'leave', false);
	end
	if curStep == 790 then
		objectPlayAnimation('unoart', 'idle2', false);
	end

	if curStep == 1184  then
		setProperty('defaultCamZoom', 1.1)
	end

	if curStep == 1190 then
		objectPlayAnimation('unoart', 'shock', false);
	end
end

function onBeatHit()
	if not lowQuality then
		objectPlayAnimation('left', 'idle', true);
		objectPlayAnimation('right', 'idle', true);

			if (curBeat % 2 == 0) then
				setProperty("left.animation.curAnim.curFrame", 1);
			end
		
			if (curBeat % 2 == 0) then
				setProperty("right.animation.curAnim.curFrame", 1);

			end
	end
end