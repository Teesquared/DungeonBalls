package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import wck.WCK;

	/**
	 * DungeonBalls
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class DungeonBalls extends WCK
	{
		private static var soundTheme:Sound = new SoundTheme() as Sound;
		private static var soundChannelTheme:SoundChannel = null;

		private static var soundHitBall:Sound = new SoundHitBall() as Sound;
		private static var soundHitChest:Sound = new SoundHitChest() as Sound;
		private static var soundHitMonster:Sound = new SoundHitMonster() as Sound;

		private static var soundLevelComplete:Sound = new SoundLevelComplete() as Sound;
		private static var soundLevelFail:Sound = new SoundLevelFail() as Sound;
		private static var soundYouWin:Sound = new SoundYouWin() as Sound;

		/**
		 * DungeonBalls
		 */
		public function DungeonBalls()
		{
			super();
		}

		/**
		 * playTheme
		 */
		public static function playTheme():void
		{
			if (soundChannelTheme == null)
				soundChannelTheme = soundTheme.play(0, 99);
		}

		/**
		 * stopTheme
		 */
		public static function stopTheme():void
		{
			if (soundChannelTheme != null)
			{
				soundChannelTheme.stop();
				soundChannelTheme = null;
			}
		}

		/**
		 * playHitBall
		 */
		public static function playHitBall():void
		{
			soundHitBall.play();
		}

		/**
		 * playHitChest
		 */
		public static function playHitChest():void
		{
			soundHitChest.play();
		}

		/**
		 * playHitMonster
		 */
		public static function playHitMonster():void
		{
			soundHitMonster.play();
		}

		/**
		 * playLevelComplete
		 */
		public static function playLevelComplete():void
		{
			soundLevelComplete.play();
		}

		/**
		 * playLevelFail
		 */
		public static function playLevelFail():void
		{
			soundLevelFail.play();
		}

		/**
		 * playYouWin
		 */
		public static function playYouWin():void
		{
			soundYouWin.play();
		}
	}
}
