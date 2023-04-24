function onEvent(n,v1,v2)


	if n == 'Flash Camera BLACK' then

	   makeLuaSprite('BlackSquare', '', 0, 0);
		makeGraphic('BlackSquare', 1280, 700, '000000')
	      addLuaSprite('BlackSquare', true);
	      setLuaSpriteScrollFactor('BlackSquare',0,0)
	      setProperty('BlackSquare.scale.x',2)
	      setProperty('BlackSquare.scale.y',2)
	      setProperty('BlackSquare.alpha',0)
		setProperty('BlackSquare.alpha',1)
		doTweenAlpha('flTw','BlackSquare',0,v1,'linear')
	end
	
	if flashingLights == false then
		setProperty('flash.visible', false);
	end

end