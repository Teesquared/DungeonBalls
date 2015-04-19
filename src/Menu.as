package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Menu
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Menu extends Screen
	{
		/**
		 * Menu
		 */
		public function Menu()
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

			buttonStart.addEventListener(MouseEvent.CLICK, onClickButtonStart);
		}

		/**
		 * onClick
		 *
		 * @param	e
		 */
		private function onClickButtonStart(e:MouseEvent):void
		{
			DB.play();
		}
	}
}
