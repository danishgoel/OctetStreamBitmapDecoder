package  
{
	import com.danishgoel.OctetStreamBitmapDecoder;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Danish Goel
	 */
	public class AssetLoader extends World 
	{
		// minimum display duration
		private var timeLeft:Number = 1;
		
		// loaded counter
		private var txtLoader:Text;
		
		// if loading done
		private var loaded:Boolean = false;
		
		// called once world is switched to this one
		override public function begin():void 
		{
			// show that we are loading images
			FP.screen.color = 0x000000;
			addGraphic(new Text("Loading Assets...", 0, 0, { color: 0xFFFFFF, size: 48, width: FP.width, align: "center" } ), 0, 0, 200);
			
			// % loaded
			txtLoader = new Text("0%", 0, 0, { color: 0xFFFF00, size: 32, width: FP.width, align: "center" } );
			addGraphic(txtLoader, 0, 0, 300);
			
			// start loading!
			new OctetStreamBitmapDecoder(Assets,
				// set loaded flag to true on complete
				function ():void {
					loaded = true;
				},
				
				// exclude JPG_ and SND_ prefixed constants
				new RegExp("^(?!JPG_|SND_).*$"),
				
				// show loading progress
				function (done:Number):void {
					txtLoader.text = Math.ceil(done * 100).toString() + "%";
				}
			);
		}
		
		override public function update():void 
		{
			// decrease time left
			timeLeft -= FP.elapsed;
			
			// if minimum screen time elapsed and all images loaded go to image display
			if (timeLeft <= 0 && loaded) {
				FP.world = new ImagesWorld;
			}
			
			super.update();
		}
		
	}

}