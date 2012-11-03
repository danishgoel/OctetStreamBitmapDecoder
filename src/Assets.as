package  
{
	/**
	 * All image assets, embedded as Octet Streams
	 * @author Danish Goel
	 */
	public class Assets 
	{
		[Embed(source = "../assets/1.png", mimeType = "application/octet-stream")]
		public static const ONE:Class;
		
		[Embed(source = "../assets/2.png", mimeType = "application/octet-stream")]
		public static const TWO:Class;
		
		[Embed(source = "../assets/3.png", mimeType = "application/octet-stream")]
		public static const THREE:Class;
		
		[Embed(source = "../assets/4.png", mimeType = "application/octet-stream")]
		public static const FOUR:Class;
		
		[Embed(source = "../assets/5.png", mimeType = "application/octet-stream")]
		public static const FIVE:Class;
		
		[Embed(source = "../assets/6.png", mimeType = "application/octet-stream")]
		public static const SIX:Class;
	}

}