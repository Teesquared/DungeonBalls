package
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 * Game
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Game extends Screen
	{
		static var level:Level;
		var lastLevel:Boolean = false;
		var returnFrame:int;
		var levelCount:int = 0;

		var timeLeft:int = 20;
		var timer:Timer = new Timer(1 * 1000);

		CONFIG::FLASH_VAR {
			var buttonGo:SimpleButton;
			var buttonReset:SimpleButton;
			var buttonQuit:SimpleButton;
			var timerText:TextField;
		}

		/**
		 * Game
		 */
		public function Game()
		{
			super();
		}

		/**
		 * onAddedToStage
		 * @param	e
		 */
		protected override function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);

			buttonGo.addEventListener(MouseEvent.CLICK, handleClickButtonGo);
			buttonReset.addEventListener(MouseEvent.CLICK, handleClickButtonReset);
			buttonQuit.addEventListener(MouseEvent.CLICK, handleClickButtonQuit);

			timerText.text = "" + timeLeft;
			timer.addEventListener(TimerEvent.TIMER, handleTimer);
			timer.start();

			DungeonBalls.playTheme();
		}

		/**
		 * handleTimer
		 *
		 * @param	e
		 */
		private function handleTimer(e:TimerEvent):void
		{
			--timeLeft;
			timerText.text = "" + timeLeft;

			if (timeLeft <= 0)
				quit();
		}

		/**
		 * quit
		 */
		private function quit():void
		{
			// game over
			DB.gotoAndStop("labelGameOver");
			timer.stop();
			DungeonBalls.stopTheme();
			DungeonBalls.playLevelFail();
		}

		/**
		 * handleClickButtonGo
		 *
		 * @param	e
		 */
		private function handleClickButtonGo(e:MouseEvent):void
		{
			level.start();
		}

		/**
		 * handleClickButtonReset
		 *
		 * @param	e
		 */
		private function handleClickButtonReset(e:MouseEvent):void
		{
			resetLevel();
		}

		/**
		 * nextLevel
		 */
		private function nextLevel():void
		{
			timeLeft += 10;
			timerText.text = "" + timeLeft;

			++levelCount;
			play();

			DungeonBalls.playLevelComplete();
		}

		/**
		 * resetLevel
		 */
		private function resetLevel():void
		{
			returnFrame = currentFrame;
			gotoAndStop("resetFrame");
		}

		/**
		 * handleClickButtonQuit
		 *
		 * @param	e
		 */
		private function handleClickButtonQuit(e:MouseEvent):void
		{
			quit();
			/// @todo: debugging just advance the level instead
			//nextLevel();
		}

		/**
		 * setLevel
		 *
		 * @param	l
		 */
		private function setLevel(l:Level, lastLevel:Boolean):void
		{
			if (!l)
				return;

			level = l;
			level.addEventListener(Level.EVENT_NO_BALLS, handleNoBalls);
			level.addEventListener(Level.EVENT_NO_CHESTS, handleNoChests);

			this.lastLevel = lastLevel;

			stop();
		}

		/**
		 * handleNoChests
		 *
		 * @param	e
		 */
		private function handleNoChests(e:Event):void
		{
			if (lastLevel) {
				DB.gotoAndStop("labelYouWin");
				timer.stop();
				DungeonBalls.stopTheme();
				DungeonBalls.playYouWin();
			}
			else
				nextLevel();
		}

		/**
		 * handleNoBalls
		 *
		 * @param	e
		 */
		private function handleNoBalls(e:Event):void
		{
			// fail
			resetLevel();
			DungeonBalls.playLevelFail();
		}

		/**
		 * ballHit
		 */
		public static function ballHit():void
		{
			if (level) {
				level.ballHit();
			}
		}

		/**
		 * chestHit
		 */
		public static function chestHit():void
		{
			if (level) {
				level.chestHit();
			}
		}
	}
}
