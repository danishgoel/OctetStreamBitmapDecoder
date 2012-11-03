package 
{
	import flash.utils.setTimeout;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Danish Goel
	 */
	public class Main extends Engine 
	{
		public function Main():void 
		{
			super(500, 500, 30, false);
		}
		
		override public function init():void 
		{
			FP.console.enable();
			
			// go to the asset loader
			FP.world = new AssetLoader();
		}
	}
	
}
