function onCreate()
    setProperty('defaultCamZoom',0.8)
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
    setProperty('defaultCamZoom',0.8)
    
    makeLuaSprite('sky', 'skyline/rosysky', -700, 0);
	setScrollFactor('sky', 0.7, 0.7);
	addLuaSprite('sky', false);
    
    makeLuaSprite('city', 'skyline/cityback', -730, 0);
	setScrollFactor('city', 0.9, 0.9);
	addLuaSprite('city', false);

    makeLuaSprite('bal', 'skyline/balcony', -700, 0);
	setScrollFactor('bal', 0.9, 0.9);
	addLuaSprite('bal', false);
	
	setObjectOrder('sky', 1)
	setObjectOrder('city', 2)
	setObjectOrder('bal', 3)
	setObjectOrder('gfGroup', 4)
	setObjectOrder('dadGroup', 5)
	setObjectOrder('bfGroup', 6)	
end
