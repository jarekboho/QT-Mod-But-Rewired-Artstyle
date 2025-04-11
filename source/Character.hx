package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.FlxCamera;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var ignoreOther:Bool = false;

  public var globalOffsets(default, set):Array<Float> = [0, 0];

  function set_globalOffsets(value:Array<Float>):Array<Float>
  {
    if (globalOffsets == null) globalOffsets = [0, 0];
    if (globalOffsets == value) return value;

    return globalOffsets = value;
  }

	public function CharactersSwitchCase()
	//Contains every character for the game.
	{
		var tex:FlxAtlasFrames;
		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF/gf-qt_assets', 'qt');
				frames = tex;
				animation.addByPrefix('cheer', 'gf cheer', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'gf idle', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'gf idle', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('preDance', 'gf pre dance0', 24, false);
				animation.addByIndices('danceLeft-alt', 'gf caramelldansen', [14, 15, 16, 17, 18, 19, 0, 1, 2, 3], "", 24, false);
				animation.addByIndices('danceRight-alt', 'gf caramelldansen', [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "", 24, false);
				animation.addByPrefix('intro', 'gf shocked', 24, true);
				animation.addByPrefix('dodge', 'gf dodge', 24, false);

				addOffset('cheer', -17, 3);
				addOffset('sad', -20, -22);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				addOffset('preDance', -1, -13);
				addOffset('danceLeft-alt', 8, -13);
				addOffset('danceRight-alt', 8, -13);
				addOffset('intro', -34, -15);
				addOffset('dodge', -14, -13);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'bf':
				var assetList = ['BF/bf_dancing', 'BF/bf_transform', 'BF/bf_dodge', 'BF/bf_death'];

    var texture:FlxAtlasFrames = Paths.getSparrowAtlas('BF/bf_assets', 'qt');

    if (texture == null)
    {
      trace('Multi-Sparrow atlas could not load PRIMARY texture: BF/bf_assets');
    }
    else
    {
      trace('Creating multi-sparrow atlas: BF/bf_assets');
      texture.parent.destroyOnNoUse = false;
    }

    for (asset in assetList)
    {
      var subTexture:FlxAtlasFrames = Paths.getSparrowAtlas(asset, 'qt');
      // If we don't do this, the unused textures will be removed as soon as they're loaded.

      if (subTexture == null)
      {
        trace('Multi-Sparrow atlas could not load subtexture: ${asset}');
      }
      else
      {
        trace('Concatenating multi-sparrow atlas: ${asset}');
        subTexture.parent.destroyOnNoUse = false;
      }

      texture.addAtlas(subTexture);
    }

frames = texture;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('cheer', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('preAttack', 'bf pre attack', 24, false);

				animation.addByPrefix('preDance', 'bf pre dance', 24, false);
				animation.addByIndices('danceLeft-alt', 'bf caramelldansen', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], "", 24, false);
				animation.addByIndices('danceRight-alt', 'bf caramelldansen', [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], "", 24, false);

				animation.addByPrefix('intro', 'bf transition', 24, false);
				animation.addByPrefix('dodge-1', 'boyfriend dodge', 24, false);
				animation.addByPrefix('dodge-0', 'bf dodge alt0', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset("cheer", 7, 4);
				addOffset('firstDeath', -37, 11);
				addOffset('deathLoop', -37, 5);
				addOffset('deathConfirm', -37, 69);
				addOffset('scared', -4);
				addOffset('preAttack', 0, 0);
				addOffset('dodge-1', -10, -16);
				addOffset('dodge-0', 4, -52);
				addOffset('preDance', 5, 12);
				addOffset('danceLeft-alt', 52, 12);
				addOffset('danceRight-alt', 52, 12);
				addOffset('intro', 6, 1);

				playAnim('idle');

				flipX = true;

			//QT mod characters:
			case 'qt':
				// QT = Cutie
				var assetList = ['QT_assets/QT_intro'];

    var texture:FlxAtlasFrames = Paths.getSparrowAtlas('QT_assets/QT');

    if (texture == null)
    {
      trace('Multi-Sparrow atlas could not load PRIMARY texture: QT_assets/QT');
    }
    else
    {
      trace('Creating multi-sparrow atlas: QT_assets/QT');
      texture.parent.destroyOnNoUse = false;
    }

    for (asset in assetList)
    {
      var subTexture:FlxAtlasFrames = Paths.getSparrowAtlas(asset);
      // If we don't do this, the unused textures will be removed as soon as they're loaded.

      if (subTexture == null)
      {
        trace('Multi-Sparrow atlas could not load subtexture: ${asset}');
      }
      else
      {
        trace('Concatenating multi-sparrow atlas: ${asset}');
        subTexture.parent.destroyOnNoUse = false;
      }

      texture.addAtlas(subTexture);
    }

frames = texture;

				animation.addByPrefix('idle', 'qt idle', 24, false); //How long until I get called out for using a weird framerate for the animation?
				animation.addByPrefix('singUP', 'qt up', 24, false);
				animation.addByPrefix('singRIGHT', 'qt right', 24, false);
				animation.addByPrefix('singDOWN', 'qt down', 24, false);
				animation.addByPrefix('singLEFT', 'qt left', 24, false);
				animation.addByPrefix('intro', 'hi_intro', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz


				addOffset('idle', 46, -27);
				addOffset("singUP", 32, 5);
				addOffset("singRIGHT", 101, -33);
				addOffset("singDOWN", 119, -119);
				addOffset("singLEFT", 97, -29);
				addOffset("intro", 48, -18);
				

				playAnim('idle');
			case 'qt_annoyed':
				//For second song
				var assetList = ['QT_assets/QT_intro'];

    var texture:FlxAtlasFrames = Paths.getSparrowAtlas('QT_assets/QT');

    if (texture == null)
    {
      trace('Multi-Sparrow atlas could not load PRIMARY texture: QT_assets/QT');
    }
    else
    {
      trace('Creating multi-sparrow atlas: QT_assets/QT');
      texture.parent.destroyOnNoUse = false;
    }

    for (asset in assetList)
    {
      var subTexture:FlxAtlasFrames = Paths.getSparrowAtlas(asset);
      // If we don't do this, the unused textures will be removed as soon as they're loaded.

      if (subTexture == null)
      {
        trace('Multi-Sparrow atlas could not load subtexture: ${asset}');
      }
      else
      {
        trace('Concatenating multi-sparrow atlas: ${asset}');
        subTexture.parent.destroyOnNoUse = false;
      }

      texture.addAtlas(subTexture);
    }

frames = texture;

				animation.addByPrefix('idle', 'qt idle', 24, false);
				animation.addByPrefix('singUP', 'qt up', 24, false);
				animation.addByPrefix('singRIGHT', 'qt right', 24, false);
				animation.addByPrefix('singDOWN', 'qt down', 24, false);
				animation.addByPrefix('singLEFT', 'qt left', 24, false);
				animation.addByPrefix('intro', 'hi_intro', 24, false);

				//glitch animations
				animation.addByPrefix('singUP-alt', 'qt up', 24, false);
				animation.addByPrefix('singDOWN-alt', 'qt down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'qt left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'qt right', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz

				addOffset('idle', 46, -27);
				addOffset("singUP", 32, 5);
				addOffset("singRIGHT", 101, -33);
				addOffset("singDOWN", 119, -119);
				addOffset("singLEFT", 97, -29);
				addOffset("intro", 48, -18);
				//alt animations
				addOffset("singUP-alt", 32, 5);
				addOffset("singRIGHT-alt", 101, -33);
				addOffset("singDOWN-alt", 119, -119);
				addOffset("singLEFT-alt", 97, -29);
				
				playAnim('idle');
			case 'robot':
				//robot = kb = killerbyte
				tex = Paths.getSparrowAtlas('QT_assets/KB');
				frames = tex;

				animation.addByPrefix('idle', "kb idle", 24, true);
				animation.addByPrefix('singUP', "kb up", 24, false);
				animation.addByPrefix('singDOWN', "kb down", 24, false);
				animation.addByPrefix('singLEFT', 'kb left', 24, false);
				animation.addByPrefix('singRIGHT', 'kb right', 24, false);


				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz

				addOffset('idle', 275, 288);
				addOffset("singLEFT", 487, 273);
				addOffset("singRIGHT", 46, 208);
				addOffset("singDOWN", 368, 135);
				addOffset("singUP", 184, 410);

				globalOffsets[0] = 93;
				globalOffsets[1] = 186;

			case 'robotV2':
				//robot = kb = killerbyte
				tex = Paths.getSparrowAtlas('QT_assets/KBV2');
				frames = tex;

				animation.addByPrefix('idle', "kb idle", 24, true);
				animation.addByPrefix('singUP', "kb up", 24, false);
				animation.addByPrefix('singDOWN', "kb down", 24, false);
				animation.addByPrefix('singLEFT', 'kb left', 24, false);
				animation.addByPrefix('singRIGHT', 'kb right', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz

				addOffset('idle', 275, 288);
				addOffset("singLEFT", 487, 273);
				addOffset("singRIGHT", 46, 208);
				addOffset("singDOWN", 368, 135);
				addOffset("singUP", 184, 410);

				globalOffsets[0] = 93;
				globalOffsets[1] = 186;

			case 'qt-kb':
				var assetList = ['QT_assets/QT_intro'];

    var texture:FlxAtlasFrames = Paths.getSparrowAtlas('QT_assets/QT');

    if (texture == null)
    {
      trace('Multi-Sparrow atlas could not load PRIMARY texture: QT_assets/QT');
    }
    else
    {
      trace('Creating multi-sparrow atlas: QT_assets/QT');
      texture.parent.destroyOnNoUse = false;
    }

    for (asset in assetList)
    {
      var subTexture:FlxAtlasFrames = Paths.getSparrowAtlas(asset);
      // If we don't do this, the unused textures will be removed as soon as they're loaded.

      if (subTexture == null)
      {
        trace('Multi-Sparrow atlas could not load subtexture: ${asset}');
      }
      else
      {
        trace('Concatenating multi-sparrow atlas: ${asset}');
        subTexture.parent.destroyOnNoUse = false;
      }

      texture.addAtlas(subTexture);
    }

frames = texture;

				animation.addByPrefix('idle', 'qt idle', 24, false);
				animation.addByPrefix('singUP', 'qt up', 24, false);
				animation.addByPrefix('singRIGHT', 'qt right', 24, false);
				animation.addByPrefix('singDOWN', 'qt down', 24, false);
				animation.addByPrefix('singLEFT', 'qt left', 24, false);
				animation.addByPrefix('intro', 'hi_intro', 24, false);

				animation.addByPrefix('singUP-alt', 'qt up', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'qt right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'qt down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'qt left', 24, false);

				animation.addByPrefix('singUP-kb', 'qt up', 24, false);
				animation.addByPrefix('singRIGHT-kb', 'qt right', 24, false);
				animation.addByPrefix('singDOWN-kb', 'qt down', 24, false);
				animation.addByPrefix('singLEFT-kb', 'qt left', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz


				addOffset('idle', 46, -27);
				addOffset("singUP", 32, 5);
				addOffset("singRIGHT", 101, -33);
				addOffset("singDOWN", 119, -119);
				addOffset("singLEFT", 97, -29);
				addOffset("intro", 48, -18);

				addOffset("singUP-alt", 32, 5);
				addOffset("singRIGHT-alt", 101, -33);
				addOffset("singDOWN-alt", 119, -119);
				addOffset("singLEFT-alt", 97, -29);

				addOffset("singUP-kb", 32, 5);
				addOffset("singRIGHT-kb", 101, -33);
				addOffset("singDOWN-kb", 119, -119);
				addOffset("singLEFT-kb", 97, -29);
			}
	}

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		
		antialiasing = true;
		CharactersSwitchCase();
		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * Used for idle animations which switch between 2 states (like GF bopping her head from right to left, then left to right). Simply use 'dance(true)' if you wish to use an alt dance animation (if the character supports it!)
	 */
	public function dance(useAltAnimation:Bool=false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				default:
					playAnim('idle');
			}
		}
	}

  var animOffsets2(default, set):Array<Float> = [0, 0];

  function set_animOffsets2(value:Array<Float>):Array<Float>
  {
    if (animOffsets2 == null) animOffsets2 = [0, 0];
    if ((animOffsets2[0] == value[0]) && (animOffsets2[1] == value[1])) return value;

    return animOffsets2 = value;
  }

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if(ignoreOther) return;
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			animOffsets2 = [daOffset[0],daOffset[1]];
		}
		else
			animOffsets2 = [0,0];

		if (curCharacter == 'gf') //wtf is this? -Haz
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

  public var characterOrigin(get, never):FlxPoint;

  function get_characterOrigin():FlxPoint
  {
    var xPos = (width / 2); // Horizontal center
    var yPos = (height); // Vertical bottom
    return new FlxPoint(xPos, yPos);
  }

  // override getScreenPosition (used by FlxSprite's draw method) to account for animation offsets.
  override function getScreenPosition(?result:FlxPoint, ?camera:FlxCamera):FlxPoint
  {
    var output:FlxPoint = super.getScreenPosition(result, camera);
    output.x -= (animOffsets2[0] - globalOffsets[0]) * this.scale.x;
    output.y -= (animOffsets2[1] - globalOffsets[1]) * this.scale.y;
    return output;
  }

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	
	//Currently crashes the game, do not use!
	//UPDATE - THIS IS NO LONGER USED AT ALL AND IS NOW OBSOLETE, DO NOT USE! -Haz
	public function swapCharacter(newCharacter:String)
		//For changing mid-song -Haz
	{

		curCharacter = newCharacter;
		CharactersSwitchCase();

		if (isPlayer)
			{
				flipX = !flipX;
	
				// Doesn't flip for BF, since his are already in the right place???
				if (!curCharacter.startsWith('bf'))
				{
					// var animArray
					var oldRight = animation.getByName('singRIGHT').frames;
					animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
					animation.getByName('singLEFT').frames = oldRight;
	
					// IF THEY HAVE MISS ANIMATIONS??
					if (animation.getByName('singRIGHTmiss') != null)
					{
						var oldMiss = animation.getByName('singRIGHTmiss').frames;
						animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
						animation.getByName('singLEFTmiss').frames = oldMiss;
					}
				}
			}
	}
}
