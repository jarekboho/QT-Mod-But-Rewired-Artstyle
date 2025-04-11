package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('gf', [2], 0, false, isPlayer);
		animation.add('robot', [3, 4], 0, false, isPlayer);
		animation.add('qt', [5, 6], 0, false, isPlayer);
		animation.add('qt_annoyed', [5, 6], 0, false, isPlayer);
		animation.add('qt-kb', [7, 8], 0, false, isPlayer);
		animation.play(char);
		antialiasing = true;
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
