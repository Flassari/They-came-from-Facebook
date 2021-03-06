package com.gogogic.gamejam.view.components.units
{
	import com.gogogic.gamejam.assets.BasicCharacter;
	import com.gogogic.gamejam.model.vo.UnitVO;
	import com.gogogic.gamejam.view.components.UnitComponent;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ShooterUnitComponent extends UnitComponent
	{
		private var _target:UnitVO;
		private var _shotIsCoolingDown:Boolean = false;
		private var _character:MovieClip;
		
		public function ShooterUnitComponent()
		{
			var unitVO:UnitVO = new UnitVO();
			unitVO.maxHealth = unitVO.currentHealth = 5;
			super(unitVO);
		}
		
		override protected function onInitDone():void {
			_character = new BasicCharacter();
			if (unitVO.isEnemy) _character.gotoAndStop(2);
			addChild(_character);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			graphics.clear();
			if (!_target || _target.currentHealth <= 0) _target = closestEnemy;
			if (!_target) return; // If there are no enemies on stage, just stop
			
			var targetPoint:Point = getLocationWithDistanceTo(_target, 130);
			var directionToPoint:Number = Math.atan2(targetPoint.y - _unitVO.y, targetPoint.x - _unitVO.x);
			var directionToUnit:Number = Math.atan2(_target.y - _unitVO.y, _target.x - _unitVO.x);
			var distance:Number = distanceTo(_target);
			
			unitVO.x += Math.cos(directionToPoint) * 1.4;
			unitVO.y += Math.sin(directionToPoint) * 1.4;
			unitVO.rotation = directionToUnit * 180 / Math.PI;
			unitVO.triggerDataChangeEvent();
			
			if (!_shotIsCoolingDown && distance < 150) {
				// SHOOT
				_shotIsCoolingDown = true;
				TweenLite.delayedCall(.5, shotCooledDown);
				
				graphics.lineStyle(1, _unitVO.isEnemy ? 0xFF0000 : 0xFFFFFF);
				graphics.moveTo(0, 0);
				graphics.lineTo( distance, 0);
				graphics.endFill();
				// TODO: show bullet
				// TODO: Target show blood, eww
				_target.currentHealth -= 4;
				_target.triggerDataChangeEvent();
			}
		}
		
		private function shotCooledDown():void {
			_shotIsCoolingDown = false;
		}
		
		override protected function onDie():void {
			dispatchEvent(new Event(Event.COMPLETE));
			// Dispose is called by the game board afterwards, no need to clean up here
		}
		
		override public function dispose():void {
			super.dispose();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}