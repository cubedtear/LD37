package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxObject;
import source.Player;

class PlayState extends FlxState
{
	private var player : Player;
	private var map : FlxOgmoLoader;
	private var walls : FlxTilemap;
	private var coinGroup : FlxTypedGroup<Coin>;

	override public function create():Void
	{
		map = new FlxOgmoLoader(AssetPaths.main__oel);
		coinGroup = new FlxTypedGroup<Coin>();
		player = new Player();

		walls = map.loadTilemap(AssetPaths.tileMap__png, 16, 16, "walls");
		walls.follow();
		walls.setTileProperties(1, FlxObject.NONE);
		walls.setTileProperties(0, FlxObject.ANY);

		FlxG.camera.follow(player, TOPDOWN, 1);
		map.loadEntities(placeEntities, "entities");

		add(walls);
		add(player);
		add(coinGroup);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coinGroup, playerTouchCoin);
	}

	private function playerTouchCoin(p: Player, c:Coin):Void
	{
		if (p.alive && p.exists && c.alive && c.exists)
		{
			c.kill();
		}
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		trace(entityName);
		if (entityName == "player")
		{
			player.x = x;
			player.y = y;
		}
		else if (entityName == "coin")
		{
			trace("new coin");
			coinGroup.add(new Coin(x, y));
		}
	}
}
