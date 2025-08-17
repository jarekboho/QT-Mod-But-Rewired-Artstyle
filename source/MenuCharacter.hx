package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxCamera;

class CharacterSetting
{
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var scale(default, null):Float;
	public var flipped(default, null):Bool;

	public function new(x:Float = 0, y:Float = 0, scale:Float = 1.0, flipped:Bool = false)
	{
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.flipped = flipped;
	}
}

class MenuCharacter extends FlxSprite
{
	
	private static var settings:Map<String, CharacterSetting> = [
		'bf' => new CharacterSetting(0, 0, 1.0, true),
		'gf' => new CharacterSetting(0, 0, 1.0, true),
		'qt' => new CharacterSetting(0, 0, 0.59, false)
	];

	private var flipped:Bool = false;

  public var animOffsets2(default, set):Array<Float> = [0, 0];

  function set_animOffsets2(value:Array<Float>):Array<Float>
  {
    if (animOffsets2 == null) animOffsets2 = [0, 0];
    if ((animOffsets2[0] == value[0]) && (animOffsets2[1] == value[1])) return value;

    return animOffsets2 = value;
  }

	public function new(x:Int, y:Int, scale:Float, flipped:Bool, character:String)
	{
		super(x, y);
		this.flipped = flipped;

		antialiasing = true;

		if(character == 'qt')
		{
		frames = Paths.getSparrowAtlas('QT');
		animation.addByPrefix('idle', "qt_idle0", 24);
		animation.addByPrefix('confirm', 'qt_hey0', 24, false);
		animation.play('idle');
		this.x = x + FlxG.width * 0.25 * 0;

		this.origin.x = 251;
		this.origin.y = 218.5;
		}

		if(character == 'bf')
		{
		frames = Paths.getSparrowAtlas('bf');
		animation.addByPrefix('idle', "idle0", 24);
		animation.addByPrefix('confirm', 'confirm0', 24, false);
		animation.play('idle');
		this.x = x + FlxG.width * 0.25 * 1;
		}

		if(character == 'gf')
		{
		frames = Paths.getSparrowAtlas('gf');
		animation.addByPrefix('idle', "idle0", 24);
		animation.play('idle');
		this.x = x + FlxG.width * 0.25 * 2;
		}

		this.scale.set(scale, scale);
	}

	public function setCharacter(character:String):Void
	{
		if (character == '')
		{
			visible = false;
			return;
		}
		else
		{
			visible = true;
		}

		//animation.play(character);

		var setting:CharacterSetting = settings[character];
		offset.set(setting.x, setting.y);
		//setGraphicSize(Std.int(width * setting.scale));
		flipX = setting.flipped != flipped;
	}

  // override getScreenPosition (used by FlxSprite's draw method) to account for animation offsets.
  override function getScreenPosition(?result:FlxPoint, ?camera:FlxCamera):FlxPoint
  {
    var output:FlxPoint = super.getScreenPosition(result, camera);
    output.x -= (animOffsets2[0]) * this.scale.x;
    output.y -= (animOffsets2[1]) * this.scale.y;
    return output;
  }
}
