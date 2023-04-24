function onEvent(n,v1,v2)


	if n == 'Hide Hud' then
		setProperty('camHUD.visible', false); 
	end
	
	if v2 == 1 then
		setProperty('camHUD.visible', true);
	end

end