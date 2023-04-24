beatSide = 0;
local u = false;
local r = 0;
local i = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 1050.95;
local yy = 1170;
local xx2 = 1872.9;
local yy2 = 1125;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;
-- -350 + Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.5) * 12.5;

function onCreate()
    setProperty('defaultCamZoom',0.8)
    makeLuaSprite('bartop','',0,-50)
    makeGraphic('bartop',1280,100,'000000')
    addLuaSprite('bartop',true)
    setObjectCamera('bartop','hud')
    setScrollFactor('bartop',0,0)

    makeLuaSprite('barbot','',0,680)
    makeGraphic('barbot',1280,100,'000000')
    addLuaSprite('barbot',true)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','hud')
    setProperty('defaultCamZoom',0.8)

	makeLuaSprite('barbg', 'barfight/bar', -700, 0);

	makeLuaSprite('barstage', 'barfight/barstage', -700, 0);
	makeLuaSprite('lights', 'barfight/lights', -700, 0);
	addLuaSprite('lights', true);
  	setProperty('lights.visible', false)
	
	if not lowQuality then
		makeAnimatedLuaSprite('box', 'barfight/Jukebox', -700, -275);
		addAnimationByPrefix('box', 'idle', 'box beat', 15, true);
		setProperty("box.scale.x", 0.4);
		setProperty("box.scale.y", 0.4);

		makeAnimatedLuaSprite('bgp1', 'barfight/makerarson', 520,  -295);
		addAnimationByPrefix('bgp1', 'idle', 'beat', 11, true);
		setProperty("bgp1.scale.x", 0.3);
		setProperty("bgp1.scale.y", 0.3);
		
		makeAnimatedLuaSprite('bgp2', 'barfight/fore', -700, 320);
		addAnimationByPrefix('bgp2', 'idle', 'forebeat', 10, true);
	end

	addLuaSprite('barbg', false);

	if not lowQuality then
		addLuaSprite('box', false);
		addLuaSprite('bgp1', false);
	end
	
	addLuaSprite('barstage', true);
	addLuaSprite('bgp2', true);
end

function onUpdate(elapsed)

	daElapsed = elapsed * 30
	i = i + daElapsed

	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
     if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.5)
        else
      
            setProperty('defaultCamZoom', 0.76)
          
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end

end

function onBeatHit()
	if not lowQuality then
		objectPlayAnimation('box', 'idle', true);
		objectPlayAnimation('bgp1', 'idle', true);
		objectPlayAnimation('bgp2', 'idle', true);
		if (curBeat % 2 == 0) then
			setProperty("box.animation.curAnim.curFrame", 15);
		end
		
		if (curBeat % 2 == 0) then
			setProperty("bgp1.animation.curAnim.curFrame", 15);

		end
		
		if (curBeat % 2 == 0) then
			setProperty("bgp2.animation.curAnim.curFrame", 11);
		end


	end
end
function onStepHit()
	if curStep == 95 then
		doTweenY('foreTweenY', 'bgp2', 0, 2, elasticInOut)
	end

	if curStep == 793 then
		setProperty('box.visible', false);
		setProperty('bgp1.visible', false);
		setProperty('bgp2.visible', false);
		setProperty('barbg.visible', false);
		setProperty('barstage.visible', false);
		setProperty('gf.visible', false);
		setProperty('lights.visible', true);
	end

	if curStep == 912 then
		setProperty('lights.visible', false);
		setProperty('gf.visible', true);
		setProperty('box.visible', true);
		setProperty('barbg.visible', true);
		setProperty('barstage.visible', true);
		setProperty('bgp1.visible', true);
		setProperty('bgp2.visible', true);
	end
	
end