package;

import flixel.addons.display.FlxExtendedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.animation.FlxAnimation;
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.effects.FlxFlicker;
import lime.utils.AssetCache;
import flixel.util.FlxTimer;
import flixel.FlxObject;

class Gallery extends MusicBeatState
{
	
var txtOptionTitle:FlxText;
var descText:FlxText;
var descBox:AttachedSprite;
var cats:Array<String> = ['cat1', 'cat2', 'cat3'];
var weekImages:Array<Dynamic> =[
['bf', 'gf', 'paige', 'uno', 'cryptid', 'egg', 'arsen', 'charr', 'melon', 'tart', 'art', 'hp', 'greeted', 'cg'],
['titlething','thumb1', 'menustuff1', 'freefall', 'cgdesign1', 'transcendent', 'barfight1', 'barfight2', 'chuckle1', 'chuckle2', 'fine', 'date1', 'earlysick'],
['m-e-l-o-n', 'YEAH', 'woah', 'WAA', 'ouch', 'LEAVE', 'hehe', 'burn', 'bpbelike']
];
var catTexts:FlxTypedGroup<FlxSprite>;
var selectionBG:FlxTypedGroup<FlxSprite>;
var curSelected:Int = 0;
var artSprites:FlxTypedGroup<FlxSprite>;
var suffix:String = '';
var stopspamming:Bool = false;
var canSelect:Bool = true;
var isDebug:Bool = false;
private var shit:FlxObject;

var offsetThing:Float = -75;
override function create()
	{

		#if debug
		isDebug = true;
		#end
		
		shit = new FlxObject(0, 0, 1, 1);
		shit.screenCenter();
		FlxG.camera.focusOn(shit.getPosition());
		var bg:FlxSprite = new FlxSprite(0,0).makeGraphic(1280,720,FlxColor.fromRGB(69,108,207),false);
		add(bg);

		var checkers:FlxBackdrop = new FlxBackdrop(Paths.image('gallery/checkers'),0,0,true,true,0,0);
		checkers.velocity.x = 20;
		checkers.velocity.y = 20;
		add(checkers);


		catTexts = new FlxTypedGroup<FlxSprite>();
		selectionBG = new FlxTypedGroup<FlxSprite>();
		add(selectionBG);
		add(catTexts);

	
		for (i in 0...cats.length){
			var catText:FlxSprite = new FlxSprite(200 + (300 * i), 200).loadGraphic(Paths.image('gallery/' + cats[i]));
			catText.antialiasing = true;
			catText.ID = i;
			catText.setGraphicSize(Std.int(catText.width * 0.8));
			catTexts.add(catText);

			switch(i)
				{
					case 0:
					catText.x += 200.95;
					catText.y += 20.5;
				
					case 1:
					catText.x += 700.95;
					catText.y += 20.5;
				
					case 2:
					catText.x += 1100.95;
					catText.y += 20.5;

				}

			}

			
		artSprites = new FlxTypedGroup<FlxSprite>();
		add(artSprites);
		artSprites.visible = false;

		for (i in 0...weekImages[0].length){
			var art:FlxSprite = new FlxSprite(80 + (400 * i), 150).loadGraphic(Paths.image('gallery/art/' + weekImages[0][i] + suffix));
				art.setGraphicSize(Std.int(art.width * 0.15));
				art.updateHitbox();
				art.antialiasing = true;
				art.scrollFactor.set(1,1);
				artSprites.add(art);
			
			}
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		changeWeek();
		


		super.create();
	

	}

	override public function update(elapsed:Float){
	
		if (controls.UI_RIGHT_P && canSelect)
			changeWeek(1);
		if (controls.UI_LEFT_P && canSelect)
			changeWeek(-1);
		if (FlxG.keys.justPressed.ESCAPE)
		FlxG.switchState(new MainMenuState());
		if (controls.ACCEPT && !stopspamming){
			selectWeek(curSelected);
			stopspamming = true;
			canSelect = false;
		}


		FlxG.camera.focusOn(shit.getPosition());
		if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;
		super.update(elapsed);
	
	
	}


	public function changeWeek(change:Int = 0):Void{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.5);
		curSelected += change;
		if (curSelected < 0)
			curSelected = cats.length - 1;
		if (curSelected >= cats.length)
			curSelected = 0;
		//if (!isDebug)

			//artSprites.members[0].loadGraphic(Paths.image('gallery/art/' + weekImages[curSelected][0] + suffix));
			//artSprites.members[1].loadGraphic(Paths.image('gallery/art/' + weekImages[curSelected][1] + suffix));
			//artSprites.members[2].loadGraphic(Paths.image('gallery/art/' + weekImages[curSelected][2] + suffix));
		for (shit in catTexts.members){
			if (change == 1)
			FlxTween.tween(shit,{x: shit.x - 700},0.5,{ease:FlxEase.cubeOut});
			if (change == -1)
			FlxTween.tween(shit,{x: shit.x + 700},0.5,{ease:FlxEase.cubeOut});	

		}

		
	}



	function selectWeek(selection:Int){
		FlxFlicker.flicker(catTexts.members[curSelected],0);
		FlxG.sound.play(Paths.sound('confirmMenu'));
		new FlxTimer().start(1, function(tmr:FlxTimer){
		persistentUpdate = false;
		persistentDraw = false;
		FlxFlicker.stopFlickering(catTexts.members[curSelected]);
		openSubState(new GallerySubState(weekImages[curSelected]));
		});
	}

	override function closeSubState(){
		canSelect = true;
		FlxG.camera.focusOn(shit.getPosition());
		FlxG.camera.zoom = 1;
		stopspamming = false;
		super.closeSubState();
	}
		
		
		
		

		


}