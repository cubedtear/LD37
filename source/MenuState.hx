package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	
	private var playBtn : FlxButton;
	
	override public function create():Void
	{
		playBtn = new FlxButton("Play", playCallback);
		playBtn.screenCenter();
		add(playBtn);
		super.create();
	}
	
	private function playCallback():Void {
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
