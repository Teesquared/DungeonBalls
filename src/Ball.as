package
{
	import Box2DAS.Dynamics.ContactEvent;
	import shapes.Circle;

	/**
	 * Ball
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Ball extends Circle
	{
		/**
		 * Ball
		 */
		public function Ball()
		{
			super();
		}

		/**
		 * create
		 */
		public override function create():void
		{
			reportBeginContact = true;
			super.create();
			listenWhileVisible(this, ContactEvent.BEGIN_CONTACT, handleContact);
		}

		/**
		 * handleContact
		 *
		 * @param	e
		 */
		public function handleContact(e:ContactEvent):void
		{
			DungeonBalls.playHitBall();
		}
	}
}
