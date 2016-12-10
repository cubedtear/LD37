package source;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Player extends FlxSprite
{

	private var speed = 200;

	public function new(?X: Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		this.makeGraphic(16, 16, FlxColor.BLUE);
		this.drag.x = this.drag.y = 1600;
		setSize(10, 10);
		offset.set(3, 3);
	}

	private function move():Void
	{
		var up = FlxG.keys.anyPressed([UP, W]);
		var down = FlxG.keys.anyPressed([DOWN, S]);
		var left = FlxG.keys.anyPressed([LEFT, A]);
		var right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down) up = down = false;
		if (left && right) left = right = false;

		if (up || down || left || right)
		{
			var angle = 0;
			if (up)
			{
				if (left) angle = -90-45;
				else if (right) angle = -45;
				else angle = -90;
			}
			else if (down)
			{
				if (left) angle = 90+45;
				else if (right) angle = 45;
				else angle = 90;
			}
			else if (left)
			{
				angle = 180;
			}
			this.velocity.set(speed, 0);
			this.velocity.rotate(FlxPoint.weak(0, 0), angle);
		}
	}
	
	override public function update(elapsed:Float):Void {
		move();
		super.update(elapsed);
	}

}