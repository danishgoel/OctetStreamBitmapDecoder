package  
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Danish Goel
	 */
	public class EmbeddedAssetLoader extends World 
	{
		// image loaded vs total
		private var totalImages:uint;
		private var loadedImages:uint = 0;
		
		// minimum display duration
		private var timeLeft:Number = 1;
		
		// loaded counter
		private var txtLoader:Text;
		
		// matching regex for assets
		private var regex:RegExp;
		
		public function EmbeddedAssetLoader(matchRegex:RegExp = null) {
			regex = matchRegex;
		}
		
		// called once world is switched to this one
		override public function begin():void 
		{
			// show that we are loading images
			FP.screen.color = 0x000000;
			addGraphic(new Text("Loading Assets...", 0, 0, { color: 0xFFFFFF, size: 48, width: FP.width, align: "center" } ), 0, 0, 200);
			
			txtLoader = new Text("0/0", 0, 0, { color: 0xFFFF00, size: 32, width: FP.width, align: "center" } );
			addGraphic(txtLoader, 0, 0, 300);
			
			// get type info (reflection)
			var assetsXML:XML = describeType(Assets);
			
			// total number of images
			totalImages = assetsXML.constant.length();
			
			// loop over all constants
			for each(var item:XML in assetsXML.constant) {
				// if no matching regex given or the regex matches
				if (regex == null || regex.test(item.@name)) {
					// load the image using the byteArray
					loadImage(Assets[item.@name]);
				}else {
					// decrement from total image count as this will not be decoded
					totalImages--;
				}
			}
		}
		
		/**
		 * Asynchronously decode the byteStream image to a bitmapData
		 * @param	byteSrc		Image byte stream
		 */
		public function loadImage(byteSrc:Class):void {
			// loader to load the image
			var loader:Loader = new Loader();
			
			// on load complete
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
				function(e:Event):void {
					// set decoded bitmap data
					byteSrc.bitmapData = Bitmap(e.target.content).bitmapData;
					
					// increment images loaded count
					loadedImages++;
					txtLoader.text = loadedImages.toString() + " / " + totalImages.toString();
				}
			);
			
			// begin load
			loader.loadBytes(ByteArray(new byteSrc));
		}
		
		override public function update():void 
		{
			// decrease time left
			timeLeft -= FP.elapsed;
			
			// if minimum screen time elapsed and all images loaded go to image display
			if (timeLeft <= 0 && loadedImages == totalImages) {
				FP.world = new ImagesWorld;
			}
			
			super.update();
		}
		
	}

}