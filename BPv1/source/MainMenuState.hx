package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;


using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;


	var menuItems:FlxTypedGroup<FlxSprite>;
	
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode', // 0
		'freeplay', // 1
		'options', // 2
		'credits', // 3
		'gallery' // 4
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var chars:FlxSprite;
	var debugKeys:Array<FlxKey>;
	var blackbar:FlxSprite;

	override function create()
	{

		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		
		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);
		
		chars = new FlxSprite();
		chars.frames = Paths.getSparrowAtlas('mainmenu/menu-chars');
		chars.animation.addByPrefix('story', "menu-chars story", 11);	
		chars.animation.addByPrefix('free', "menu-chars freeplay", 11, false);		
		chars.animation.addByPrefix('opt', "menu-chars options", 11, false);	
		chars.animation.addByPrefix('creds', "menu-chars credits", 11, false);	
		chars.animation.play('story');
		chars.screenCenter();
		add(chars);
		chars.antialiasing = ClientPrefs.globalAntialiasing;
		
		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBGNight'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		//magenta.color = 0xFFfd719b;
		//add(magenta);
		

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite((i * 300) + 70, 600);
			menuItem.y = 0;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItems.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.34));
			menuItem.updateHitbox();

			switch(i)
			{
				case 0:
					menuItem.x -= 20.95;

				
				case 1:
					menuItem.x -= 20.95;

				
				case 2:
					menuItem.x -= 20.95;


				case 3:
					menuItem.x -= 20.95;

				
				case 4:
					menuItem.x -= 250.95;
					menuItem.y += 600.4;
			}
		}




		//FlxG.camera.follow(camFollowPos, null, 1);


		var versionShit:FlxText = new FlxText(16, FlxG.height - 44, 0, "Story Mode is Not Yet Available", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("delius", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(16, FlxG.height - 24, 0, "FNF: Blank Pages V1", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("delius", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	var ghost:Float = 0;

	override function update(elapsed:Float)
	{
			switch (ghost){
			
				case 0:
					if (FlxG.keys.justPressed.B)
						ghost += 1;
				case 1:
					if (FlxG.keys.justPressed.R)
						ghost += 1;
				case 2:
					if (FlxG.keys.justPressed.U)
						ghost += 1;
				case 3:
					if (FlxG.keys.justPressed.H) {
						PlayState.SONG = Song.loadFromJson('taco-bell-hard', 'taco-bell');
						PlayState.isStoryMode = false;
						PlayState.storyDifficulty = 0;
						FlxG.sound.play(Paths.sound('cancelMenu'));
						LoadingState.loadAndSwitchState(new PlayState());
					}
			}


		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));


		if (!selectedSomethin)
		{
			if (controls.UI_LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new IntroState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{	
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										FlxG.sound.play(Paths.sound('cancelMenu'));
										MusicBeatState.switchState(new MainMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
									case 'gallery':
										LoadingState.loadAndSwitchState(new Gallery());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}

	override function beatHit() {
		super.beatHit();

		if (curBeat % 4 == 2) {
			FlxG.camera.zoom = 1.02;
		} 
	}

		function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		switch (curSelected)
		{
			case 0:
				chars.animation.play('story');
			case 1:
				chars.animation.play('free');
				chars.animation.finishCallback = function(free)
					{
						chars.animation.play('free');
					}

			case 2:
				chars.animation.play('opt');
				chars.animation.finishCallback = function(opt)
					{
						chars.animation.play('opt');
					}

			case 3:
				chars.animation.play('creds');
				chars.animation.finishCallback = function(creds)
					{
						chars.animation.play('creds');
					}

		}
		
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				//spr.centerOffsets();
			}
		});
	}
}
