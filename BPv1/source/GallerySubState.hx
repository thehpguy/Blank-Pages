package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.addons.display.FlxBackdrop;
import flixel.tweens.FlxTween;
class GallerySubState extends MusicBeatSubstate
{

var images:Array<String>;

var curSelected:Int = 0;
private var camFollow:FlxObject;
var artSprites:FlxTypedGroup<FlxSprite>;
var colorBG:FlxSprite;
var blackbar:FlxSprite;
var canSelect:Bool = true;

var text:Alphabet;
public function new(_images:Array<String>){

    super();
    images = _images;
    trace(images);
    for (v in 0...images.length){
    images.remove('void');
    }
    blackbar = new FlxSprite(0).loadGraphic(Paths.image('gallery/menubars'));
    blackbar.screenCenter();
	blackbar.setGraphicSize(Std.int(blackbar.width * 2.5));
    blackbar.scrollFactor.set(0,0);
	add(blackbar);
	blackbar.antialiasing = ClientPrefs.globalAntialiasing;

    colorBG = new FlxSprite(0,0).makeGraphic(1280,720);
    colorBG.scrollFactor.set(0,0);
    //add(colorBG);   
    
    //var topbars:FlxBackdrop = new FlxBackdrop(Paths.image('gallery/menubars'),5,5,true,true,5,5);
    //topbars.velocity.x = 40;
    //topbars.velocity.y = 40;
    //add(topbars);

    camFollow = new FlxObject(0, 0, 1, 1);
    artSprites = new FlxTypedGroup<FlxSprite>();
    FlxG.camera.zoom = 0.2;
    add(artSprites);




    for (i in 0...images.length){
        var art:FlxSprite = new FlxSprite(4200 * i, 50).loadGraphic(Paths.image("gallery/art/" + images[i]));
        artSprites.add(art);
    
    }
        
	camFollow.x = artSprites.members[0].getMidpoint().x;
    camFollow.y = artSprites.members[0].getMidpoint().y;
    changeSelection();
	
}

override function update(elapsed:Float){

    FlxG.camera.focusOn(camFollow.getPosition());
    if (controls.BACK){
        FlxG.sound.play(Paths.sound('cancelMenu')); 
        close();
    }
    if (controls.UI_LEFT_P && canSelect)
        changeSelection(-1);
    if (controls.UI_RIGHT_P && canSelect)
        changeSelection(1);


    super.update(elapsed);
}


function changeSelection(change:Int = 0):Void
	{
		
        canSelect = false;
        curSelected += change;
        
		if (curSelected < 0)
			curSelected = images.length - 1;
		if (curSelected >= images.length)
			curSelected = 0;

        switch (images[curSelected]){
            case 'bf':
            tweencol(79,88,151);
            case 'gf':
            tweencol(184,90,186);
        }
            

        FlxTween.tween(camFollow, {x : artSprites.members[curSelected].getMidpoint().x, y:artSprites.members[curSelected].getMidpoint().y},0.8, {ease: FlxEase.smoothStepOut, onComplete: function(twn:FlxTween){canSelect = true;}});
    }

    function tweencol(color1:Int, color2:Int,color3:Int){

    FlxTween.color(colorBG,1.0,colorBG.color,FlxColor.fromRGB(color1,color2,color3));
    }





}
