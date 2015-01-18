package
{
	import flash.display.Sprite;
	
	import org.osmf.layout.HorizontalAlign;
	
	import utils.ArrayUtils;
	import utils.MathUtils;
	
	public class MontyHall extends Sprite
	{
		private static const GOAT:String = "Goat";
		private static const CAR:String = "Car";
		
		private static const DISABLE_INTERNAL_LOGS:Boolean = true;
		
		private var choices:Array = [GOAT,CAR,GOAT];

		private var playerSwitches:Boolean = true;
		private var playerDoor:int;
		private var goatDoor:int;
		
		private static var wins:int;
		private static var losses:int;
		private static var totalPlays:int=100000;
		
		
		
		public function MontyHall()
		{
			var startTime:Number = new Date().time;
			
			for (var i:int = 0; i < totalPlays; i++) 
			{
				playGame(playerSwitches);
			}
			
			trace("Status :: switched : ",playerSwitches," won : ",wins," lost : ",losses," win percentage : ",(wins/totalPlays)*100)
			trace("Time for ",totalPlays," plays : ",(new Date().time - startTime)," ms")
		}
		
		
		private function playGame(isSwitching:Boolean):void
		{
			ArrayUtils.shuffleArray(choices);
			if(!DISABLE_INTERNAL_LOGS)
				trace(choices);
			
			playerDoor = MathUtils.getRandomIntegerBetween(0,2);
			if(!DISABLE_INTERNAL_LOGS)
				trace("player chose : ",playerDoor);
			
			goatDoor = getGoatDoor();
			if(!DISABLE_INTERNAL_LOGS) 
				trace("host opened : ",goatDoor)
			
			//ask for switch 
			if(isSwitching)
			{
				playerDoor = getSwitchedDoor();
				if(!DISABLE_INTERNAL_LOGS) 
					trace("Player switched to : ",playerDoor)
			}
			
			
			//results
			if(choices[playerDoor] == CAR)
			{
				if(!DISABLE_INTERNAL_LOGS)
					trace("player won")
				wins++;
			}
			else
			{
				if(!DISABLE_INTERNAL_LOGS) 
					trace("player lost")
				losses++;
			}
		}
		
		
		private function getGoatDoor():int
		{
			for (var idxItem:int = 0; idxItem < choices.length; idxItem++) 
			{
				if(choices[idxItem] == GOAT && idxItem != playerDoor)
					return idxItem;
			}
			
			return -1;
		}		
		
		
		private function getSwitchedDoor():int
		{
			for (var idxItem:int = 0; idxItem < choices.length; idxItem++) 
			{
				if(idxItem != playerDoor && idxItem != goatDoor)
					return idxItem;
			}
			
			return -1;
		}
		
	}
}