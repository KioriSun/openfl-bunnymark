package;

import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

class Main extends Sprite
{

	private var addingBunnies:Bool;
	private var bunnies:Array<Bunny>;
	private var fps:FPS;
	private var gravity:Float;
	private var minX:Int;
	private var minY:Int;
	private var maxX:Int;
	private var maxY:Int;
	private var tilemap:Tilemap;
	private var tileset:Tileset;
	private var count:Int = 0;
	private var countField:TextField;
	private var countFormat:TextFormat;

	public function new ()
	{

		super ();

		bunnies = new Array ();

		var countFormat:TextFormat = new TextFormat("Verdana", 24, 0x000000, true);
		countFormat.align = TextFormatAlign.LEFT;
		countField = new TextField();
		addChild(countField);
		countField.width = 500;
		countField.y = stage.stageHeight - 40;
		countField.x = 10;
		countField.border = false;
		countField.selectable = true;

		countField.defaultTextFormat = countFormat;

		minX = 0;
		maxX = stage.stageWidth;
		minY = 0;
		maxY = stage.stageHeight - 70;
		gravity = 0.5;

		var bitmapData = Assets.getBitmapData ("assets/wabbit_alpha.png");
		tileset = new Tileset (bitmapData);
		tileset.addRect (bitmapData.rect);

		tilemap = new Tilemap (stage.stageWidth, stage.stageHeight, tileset);
		addChild (tilemap);

		fps = new FPS ();
		addChild (fps);

		stage.addEventListener (MouseEvent.MOUSE_DOWN, stage_onMouseDown);
		stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		stage.addEventListener (Event.ENTER_FRAME, stage_onEnterFrame);

		for (i in 0...100)
		{

			addBunny ();

		}

	}

	private function addBunny ():Void
	{

		var bunny = new Bunny ();
		bunny.x = 0;
		bunny.y = 0;
		bunny.speedX = Math.random () * 5;
		bunny.speedY = (Math.random () * 5) - 2.5;
		bunnies.push (bunny);
		tilemap.addTile (bunny);

	}

	// Event Handlers

	private function stage_onEnterFrame (event:Event):Void
	{

		for (bunny in bunnies)
		{

			bunny.x += bunny.speedX;
			bunny.y += bunny.speedY;
			bunny.speedY += gravity;

			if (bunny.x > maxX)
			{

				bunny.speedX *= -1;
				bunny.x = maxX;

			}
			else if (bunny.x < minX)
			{

				bunny.speedX *= -1;
				bunny.x = minX;

			}

			if (bunny.y > maxY)
			{

				bunny.speedY *= -0.8;
				bunny.y = maxY;

				if (Math.random () > 0.5)
				{

					bunny.speedY -= 3 + Math.random () * 4;

				}

			}
			else if (bunny.y < minY)
			{

				bunny.speedY = 0;
				bunny.y = minY;

			}

		}

		if (addingBunnies)
		{

			for (i in 0...100)
			{

				addBunny ();

			}

		}

	}

	private function stage_onMouseDown (event:MouseEvent):Void
	{

		addingBunnies = true;

	}

	private function stage_onMouseUp (event:MouseEvent):Void
	{

		addingBunnies = false;
		count = bunnies.length;
		countField.text = "Bunnies: " + count;

	}

}