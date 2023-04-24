function onCreate()
	-- background shit
	makeLuaSprite('concert', 'concert', -600, 0);
	setScrollFactor('concert', 0.9, 0.9);
	addLuaSprite('concert', false);
	setProperty("concert.scale.x", 1.55);
	setProperty("concert.scale.y", 1.5);
	
	-- sprites that only load if Low Quality is turned off
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end