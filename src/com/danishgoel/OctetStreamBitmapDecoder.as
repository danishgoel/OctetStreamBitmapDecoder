/**
 * An asynchronous bitmap data decoder, for assets embedded as octet streams
 * 
 * @author Danish Goel
 * @copyright 2012 Danish Goel
 * @license MIT License
 */
package com.danishgoel 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @author Danish Goel
	 */
	public class OctetStreamBitmapDecoder
	{
		// image loaded vs total
		public var _totalImages:uint;
		public var _loadedImages:uint = 0;
		
		// matching regex for assets
		private var _regex:RegExp;
		
		// call on loading complete
		private var _onComplete:Function;
		
		// call on each image decode
		private var _onProgress:Function;
		
		/**
		 * Initialize the asset loader
		 * 
		 * @param	assetsClass		The class which contains the embedded octet-stream bitmaps
		 * @param	onLoadComplete	[optional] function to call once all the images are decoded
		 * @param	matchRegex		[optional] only decode constants matching the given regex
		 * @param	onProgress		[optional] call on each image decode with percent complete
		 */
		public function OctetStreamBitmapDecoder(assetsClass:Class, onComplete:Function = null, matchRegex:RegExp = null, onProgress:Function = null) {
			// assign parameters
			_regex = matchRegex;
			_onComplete = onComplete;
			_onProgress = onProgress;
			
			// get type info (reflection)
			var assetsXML:XML = describeType(assetsClass);
			
			// total number of images
			_totalImages = assetsXML.constant.length();
			
			// loop over all constants
			for each(var item:XML in assetsXML.constant) {
				var notDecodable:Boolean = true;
				
				// if item is of type Class and matches the given regex (if any)
				if (item.@type == "Class" && (_regex == null || _regex.test(item.@name))) {
					// if its also a ByteArray
					if (new assetsClass[item.@name] is ByteArray) {
						// load the image using the byteArray
						loadImage(assetsClass[item.@name]);
						
						// and it is decodable
						notDecodable = false;
					}
				}
				
				// if the constant is not decodable, remove it from total count
				if (notDecodable) _totalImages--;
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
					_loadedImages++;
					
					// call progress callback if defined
					if (_onProgress != null) _onProgress(Number(_loadedImages) / _totalImages);
					
					// if all images loaded
					if (_totalImages == _loadedImages) {
						// and onComplete defined
						if (_onComplete != null)
							// call it
							_onComplete();
					}
				}
			);
			
			// begin load
			loader.loadBytes(ByteArray(new byteSrc));
		}
	}
}