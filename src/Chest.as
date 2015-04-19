package
{
	import Box2DAS.Dynamics.ContactEvent;
	import flash.display.MovieClip;
	import shapes.Box;

	/**
	 * Chest
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Chest extends Box
	{

		/**
		 * Chest
		 */
		public function Chest()
		{
			super();
		}

		/**
		 * create
		 */
		public override function create():void {
			reportBeginContact = true;
			super.create();
			listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, handleContact);
		}

		/**
		 * handleContact
		 *
		 * @param	e
		 */
		public function handleContact(e:ContactEvent):void {
			var b:Ball = e.other.m_userData as Ball;

			if (b) {
				b.remove();
				Game.ballHit();

				var p:MovieClip = parent as MovieClip;

				if (p)
					p.stop();

				remove();
				Game.chestHit();

				DungeonBalls.playHitChest();
			}
		}
	}
}
