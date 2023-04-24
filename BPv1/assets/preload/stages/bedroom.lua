function onCreate()    	

	setObjectOrder('gfGroup', 3)
	setObjectOrder('dadGroup', 2)
	setObjectOrder('bfGroup', 1)
	
	makeLuaSprite('room', 'they-fine/bedroom', -700, 0);
	setScrollFactor('room', 0.9, 0.9);
	addLuaSprite('room', false);

	makeLuaSprite('blur', 'they-fine/blur', 0, 0);
	addLuaSprite('blur', false);
    	setObjectCamera('blur','hud')
    	setScrollFactor('blur',0,0)

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
end

