package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Help
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Help extends Screen
	{
		/**
		 * Help
		 */
		public function Help()
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
			DB.play();
		}
	}
}
