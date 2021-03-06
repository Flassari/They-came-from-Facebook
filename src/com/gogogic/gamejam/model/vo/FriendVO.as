package com.gogogic.gamejam.model.vo
{
	
	public class FriendVO extends BaseVO
	{
		public var id:Number;
		public var firstName:String;
		public var lastName:String;
		public var name:String;
		public var portraitUrl:String;
		
		public var bonuses:Vector.<BonusVO> = new Vector.<BonusVO>();
		public var unitType:UnitTypeBaseVO;
		public var energyCost:Number;
		
		// have we killed this friend at any point this round?
		public var killedThisSession:Boolean = false;
		
		// facebook info
		public var relationship:String; //son/daughter/brother/sister/father/mother/engaged/married/complicated etc
		public var gender:String; // male or female
		public var developer:Boolean;
		
		
		
		//public var friendCount:int;
		//public var mutualFriendCount:int;
		//public var age:Number; // may be NaN if they haevn't shared their year
	}
}