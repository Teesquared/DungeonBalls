package
{
	import Box2DAS.Dynamics.ContactEvent;
	import shapes.Box;

	/**
	 * MonsterBox
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class MonsterBox extends Box
	{
		/**
		 * MonsterBox
		 */
		public function MonsterBox()
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
				remove();
				DungeonBalls.playHitMonster();
			}
		}
	}
}
