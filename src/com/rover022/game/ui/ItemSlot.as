package com.rover022.game.ui {
import com.rover022.game.TouchArea;
import com.rover022.game.events.ItemEvent;
import com.rover022.game.items.Item;
import com.rover022.game.utils.DebugTool;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.TouchEvent;

public class ItemSlot extends TouchArea {
    public var item:Item = null;
    public var enbale:Boolean = true;

    public var bgContainer:Sprite;
    public var bottomIcon:Image;
    public var selectIcon:Image;
    //

    private static const SIZE:int = 58;

    public function ItemSlot(item:Item = null) {

//        var s:Button;

        this.item = item;
        bgContainer = new Sprite();
        addChild(bgContainer);
        "#293b93"
        bottomIcon = DebugTool.makeImage(SIZE, 0x293b93);
        addChild(bottomIcon);
        "#d7cc19"
        selectIcon = DebugTool.makeRectImage(SIZE, 0xd7cc19);
        addChild(selectIcon);

        selectIcon.visible = false;
    }


    /**
     * 道具按钮被按下时候
     * @param e
     */
    override protected function onTouchDown(e:TouchEvent):void {
        if (enbale == false) {
            return
        }
        var event:ItemEvent = new ItemEvent(ItemEvent.ITEM_CLICK, true, this);
        //dispatchEvent(e);
        dispatchEvent(event);
    }

    public function setEnable(b:Boolean):void {

    }

    public function setItem(src:Item):void {
        item = src;
    }

    public function unSelect():void {
        selectIcon.visible = false;
    }

    public function select():void {
        selectIcon.visible = true;
    }
}
}
