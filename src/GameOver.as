package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * GameOver
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class GameOver extends Screen
	{
		/**
		 * GameOver
		 */
		public function GameOver()
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

			buttonOk.addEventListener(MouseEvent.CLICK, onClickButtonOk);
		}

		/**
		 * onClick
		 *
		 * @param	e
		 */
		private function onClickButtonOk(e:MouseEvent):void
		{
			DB.gotoAndStop("labelMenu");
		}
	}
}
