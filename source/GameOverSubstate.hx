package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flxanimate.FlxAnimate;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	var bfDeathSprite:FlxSprite;

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		daBf = 'bf';

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		if(PlayState.deathBySawBlade){
		bf.visible = false;
			bfDeathSprite = new FlxSprite();
			bfDeathSprite.frames = Paths.getSparrowAtlas('BF/bf_dies');
			bfDeathSprite.animation.addByPrefix('firstDeath', 'bf fuckin dies lol', 26, false);
			bfDeathSprite.animation.addByPrefix('deathLoop', 'bf dead loop', 24, true);
			bfDeathSprite.animation.addByPrefix('deathConfirm', 'bf undeading', 24, false);
			bfDeathSprite.antialiasing = true;
			bfDeathSprite.screenCenter();
			bfDeathSprite.scrollFactor.set(0, 0);
			bfDeathSprite.animation.play("firstDeath");
			add(bfDeathSprite);

			FlxG.camera.flash(0xFFff0000, 1);

		camFollow.x = bfDeathSprite.x + 60;
		camFollow.y = bfDeathSprite.y - 30;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			if(PlayState.deathBySawBlade){
				bfDeathSprite.animation.play('deathLoop');
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			if(bfDeathSprite != null)
			bfDeathSprite.animation.play('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
