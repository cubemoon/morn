/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.editor.core.IBox;
	import flash.display.DisplayObject;
	
	/**容器类*/
	public class Box extends Component implements IBox {
		public function Box() {
			mouseChildren = true;
		}
		
		/**添加显示对象*/
		public function addElement(element:DisplayObject, x:Number, y:Number):void {
			element.x = x;
			element.y = y;
			addChild(element);
		}
		
		/**增加显示对象到index层*/
		public function addElementAt(element:DisplayObject, index:int, x:Number, y:Number):void {
			element.x = x;
			element.y = y;
			addChildAt(element, index);
		}
		
		/**批量增加显示对象*/
		public function addElements(elements:Array):void {
			for (var i:int = 0, n:int = elements.length; i < n; i++) {
				var item:DisplayObject = elements[i];
				addChild(item);
			}
		}
		
		/**删除子显示对象*/
		public function removeElement(element:DisplayObject):void {
			if (element != null && contains(element)) {
				removeChild(element);
			}
		}
		
		/**删除所有子显示对象*/
		public function removeAllChild():void {
			for (var i:int = numChildren - 1; i > -1; i--) {
				removeChildAt(i);
			}
		}
		
		/**增加显示对象到某对象上*/
		public function insertAbove(element:DisplayObject, compare:DisplayObject):void {
			var index:int = getChildIndex(compare);
			if (contains(element)) {
				var oldIndex:int = getChildIndex(element);
				if (oldIndex > index) {
					index = index + 1;
				}
				setChildIndex(element, Math.min(index, numChildren - 1));
			} else {
				addChildAt(element, Math.min(index + 1, numChildren - 1));
			}
		}
		
		/**增加显示对象到某对象下*/
		public function insertBelow(element:DisplayObject, compare:DisplayObject):void {
			var index:int = getChildIndex(compare);
			if (contains(element)) {
				var oldIndex:int = getChildIndex(element);
				if (oldIndex < index) {
					index = index - 1;
				}
				setChildIndex(element, Math.max(index, 0));
			} else {
				addChildAt(element, Math.max(index, 0));
			}
		}
		
		/**立即渲染组件*/
		override public function validate():void {
			validateChild();
			super.validate();
		}
		
		protected function validateChild():void {
			for (var i:int = 0, n:int = numChildren; i < n; i++) {
				var item:Component = getChildAt(i) as Component;
				if (item != null) {
					item.validate();
				}
			}
		}
	}
}