package
{
	import Box2DAS.Common.V2;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import wck.World;

	/**
	 * Level
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Level extends World
	{
		static const EVENT_NO_BALLS:String = "EVENT_NO_BALLS";
		static const EVENT_NO_CHESTS:String = "EVENT_NO_CHESTS";

		var arrow1:Arrow;
		var ball1:Ball;

		var arrow2:Arrow;
		var ball2:Ball;

		var ball:Ball;
		var arrow:Arrow;

		var dispatchedEvent:Boolean = false;

		var ballsLeft:int = 2;
		var chestsLeft:int = 0;

		/**
		 * Level
		 */
		public function Level()
		{
			super();
		}

		/**
		 * create
		 */
		public override function create():void
		{
			// call create when play clicks start so just setup the mouse control and arrows
			super.create();

			arrow1 = new Arrow();
			arrow1.visible = false;
			addChild(arrow1);

			arrow2 = new Arrow();
			arrow2.visible = false;
			addChild(arrow2);

			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);

			chestsLeft = getNumChests(this);
		}

		/**
		 * getNumChests
		 *
		 * @param	obj
		 * @return
		 */
		private function getNumChests(obj:DisplayObjectContainer):int
		{
			var result:int = 0;

			for (var i:uint = 0; i < obj.numChildren; ++i) {
				var child:DisplayObject = obj.getChildAt(i);

				var chest:Chest = child as Chest;

				if (chest) {
					++result;
					continue;
				}

				var container:DisplayObjectContainer = child as DisplayObjectContainer;

				if (container) {
					result += getNumChests(container);
					continue;
				}
			}

			return result;
		}

		/**
		 * ballHit
		 */
		public function ballHit():void
		{
			if (ballsLeft > 0) {
				--ballsLeft;
			}
		}

		/**
		 * chestHit
		 */
		public function chestHit():void
		{
			if (chestsLeft > 0) {
				--chestsLeft;
			}
		}

		/**
		 * start
		 */
		public function start():Boolean
		{
			if (!ball1 || !ball2)
				return false;

			if (!arrow1 || !arrow2)
				return false;

			applyImpulse(ball1, arrow1);
			applyImpulse(ball2, arrow2);
			paused = false;

			ball1 = ball2 = null;
			arrow1 = arrow2 = null;

			return true;
		}

		/**
		 * applyImpulse
		 *
		 * @param	ball
		 * @param	arrow
		 */
		private function applyImpulse(ball:Ball, arrow:Arrow)
		{
			arrow.visible = false;

			var vx:Number = Math.cos(arrow.rotation * Math.PI / 180) * arrow.scaleX;
			var vy:Number = Math.sin(arrow.rotation * Math.PI / 180) * arrow.scaleY;

			ball.b2body.ApplyImpulse(new V2(vx, vy), ball.b2body.GetWorldCenter());
		}

		/**
		 * handleMouseDown
		 *
		 * @param	e
		 */
		private function handleMouseDown(e:MouseEvent):void
		{
			if (!paused)
				return;

			arrow = e.target as Arrow;

			if (arrow) {
				if (arrow == arrow1)
					ball = ball1;
				else
					ball = ball2;
			}
			else {
				ball = e.target as Ball;
			}

			if (ball) {
				if (ball1 == null || ball == ball1) {
					ball1 = ball;
					arrow1.visible = true;
					arrow = arrow1;
				}
				else if (ball2 == null || ball == ball2) {
					ball2 = ball;
					arrow2.visible = true;
					arrow = arrow2;
				}

				stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);

				arrow.x = ball.x;
				arrow.y = ball.y;

				handleMouseMove(null);

				return;
			}
		}

		/**
		 * handleMouseMove
		 *
		 * @param	e
		 */
		private function handleMouseMove(e:MouseEvent):void
		{
			if (ball)
			{
				var dx:Number = mouseX - ball.x;
				var dy:Number = mouseY - ball.y;

				arrow.rotation = Math.atan2(dy, dx) * 180 / Math.PI;

				var scale:Number = Math.sqrt(dx * dx + dy * dy) / 96;

				if (scale < 0.1)
					scale = 0.1;
				else if (scale > 1.5)
					scale = 1.5;

				arrow.scaleX = arrow.scaleY = scale;
			}
		}

		/**
		 * handleMouseUp
		 *
		 * @param	e
		 */
		private function handleMouseUp(e:MouseEvent):void
		{
			if (stage) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			}

			ball = null;
			arrow = null;
		}

		/**
		 * step
		 */
		public override function step(e:Event = null):void
		{
			if (paused) {
				return;
			}

			super.step(e);

			if (!dispatchedEvent)
			{
				var e:Event = null;

				if (chestsLeft <= 0)
					e = new Event(EVENT_NO_CHESTS);
				else if (ballsLeft <= 0)
					e = new Event(EVENT_NO_BALLS);

				if (e) {
					dispatchEvent(e);
					dispatchedEvent = true;
				}
			}
		}
	}
}
