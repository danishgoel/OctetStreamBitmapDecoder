package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Danish Goel
	 */
	public class ImagesWorld extends World 
	{
		// all the images to rotate
		private var imgs:Vector.<Stamp>;
		
		// image display entity
		private var imgEntity:Entity;
		
		// current image index
		private var idx:uint;
		
		public function ImagesWorld() 
		{
			// add all images to the list as Stamps
			imgs = new Vector.<Stamp>();
			imgs.push(new Stamp(Assets.ONE.bitmapData));
			imgs.push(new Stamp(Assets.TWO.bitmapData));
			imgs.push(new Stamp(Assets.THREE.bitmapData));
			imgs.push(new Stamp(Assets.FOUR.bitmapData));
			imgs.push(new Stamp(Assets.FIVE.bitmapData));
			imgs.push(new Stamp(Assets.SIX.bitmapData));
		}
		
		override public function begin():void 
		{
			// show first image
			imgEntity = addGraphic(imgs[0]);
			idx = 0;
		}
		
		override public function update():void 
		{
			// rotate through images using left and right keys
			if (Input.pressed(Key.LEFT)) {
				if(idx == 0) idx = imgs.length - 1;
				else idx--;
				
				imgEntity.graphic = imgs[idx];
			}else if (Input.pressed(Key.RIGHT)) {
				if (idx == imgs.length - 1) idx = 0;
				else idx++;
				
				imgEntity.graphic = imgs[idx];
			}
			
			super.update();
		}
		
	}

}