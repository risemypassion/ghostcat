package ghostcat.display.graphics
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import ghostcat.display.GBase;
	import ghostcat.skin.PointSkin;
	import ghostcat.ui.CursorSprite;
	import ghostcat.util.core.ClassFactory;

	/**
	 * 可拖动操控点
	 * 可监听其MoveEvent事件来执行操作
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class DragPoint extends GBase
	{
		public static var defaultSkin:ClassFactory = new ClassFactory(PointSkin);
		
		public var lockX:Boolean = false;
		public var lockY:Boolean = false;
		
		
		private var localMousePoint:Point;//按下时的鼠标位置
		
		/**
		 * 鼠标是否按下
		 */
		public function get mouseDown():Boolean
		{
			return localMousePoint!=null;
		}

		/**
		 * 
		 * @param skin	皮肤
		 * @param replace	是否替换
		 * @param point	由外部引入坐标对象，位置的更改将会应用到此对象上
		 * 
		 */
		public function DragPoint(point:Point=null,skin:DisplayObject=null,replace:Boolean=true) : void
		{
			if (!skin)
				skin = defaultSkin.newInstance();
			
			super(skin, replace);
			
			if (!point)
				point = new Point();
			
			this.position = point;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			
			this.cursor = "drag";
			enabled = enabled;
			
			this.positionCall.frame = false;
//			this.delayUpatePosition = true;//设置此属性是为了消除闪烁
		}

		private function onMouseDownHandler(event : MouseEvent) : void
		{
			if (enabled)
			{
				localMousePoint = new Point(x - parent.mouseX,y - parent.mouseY);
				
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
				
				CursorSprite.instance.lock = true;
			}
		}

		private function onMouseUpHandler(event : MouseEvent) : void
		{
			localMousePoint = null;
			
			invalidatePosition();
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			
			CursorSprite.instance.lock = false;
		}

		private function onMouseMoveHandler(event : MouseEvent) : void
		{
			if (!lockX)
				x = parent.mouseX + localMousePoint.x;
			if (!lockY)
				y = parent.mouseY + localMousePoint.y;
		}
		/** @inheritDoc*/
		public override function set enabled(value : Boolean) : void
		{
			mouseEnabled = super.enabled = value;
		}
	}
}