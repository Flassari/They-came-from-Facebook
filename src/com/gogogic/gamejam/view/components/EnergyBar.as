package com.gogogic.gamejam.view.components
{
	import com.gogogic.gamejam.Settings;
	import com.gogogic.gamejam.model.vo.PlayerVO;
	import com.gogogic.gamejam.model.vo.event.DataChangeEvent;
	import com.gogogic.ggamejam.assets.EnergyBarGraphic;
	
	import flash.display.Sprite;
	
	public class EnergyBar extends Sprite
	{
		private var _playerVO:PlayerVO;
		private var _energyBarGraphic:EnergyBarGraphic;
		
		public function EnergyBar(playerVO:PlayerVO)
		{
			addChild(_energyBarGraphic = new EnergyBarGraphic());
			_playerVO = playerVO;
			_playerVO.addEventListener(DataChangeEvent.DATA_CHANGE, onPlayerVODataChange);
			update();
		}
		
		private function onPlayerVODataChange(e:DataChangeEvent):void {
			update();
		}
		
		private function update():void {
			_energyBarGraphic.mcMainEnergy.scaleX = _playerVO.energy / Settings.MAX_ENERGY;
			_energyBarGraphic.mcChargingEnergy.scaleX = _playerVO.reserveEnergy / Settings.MAX_ENERGY;
		}
	}
}