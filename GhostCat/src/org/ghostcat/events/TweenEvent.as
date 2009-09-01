package org.ghostcat.events
{
	import flash.events.Event;
	
	import org.ghostcat.util.TweenUtil;
	
	/**
	 * 缓动类时间 
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class TweenEvent extends Event
	{
		public static const TWEEN_START:String="tween_start";
		public static const TWEEN_END:String="tween_end";
		public static const TWEEN_UPDATE:String="tween_update";
		
		public function TweenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}