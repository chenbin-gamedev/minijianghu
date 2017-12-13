package com.rover022.game.windows {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.hero.Belongings;
import com.rover022.game.events.ItemEvent;
import com.rover022.game.items.EquipableItem;
import com.rover022.game.items.Item;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.ui.ItemSlot;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.DebugTool;
import com.rover022.game.windows.wnditems.GridLayoutSprite;
import com.rover022.game.windows.wnditems.Tab;

import starling.display.Button;
import starling.events.Event;

/**
 * 包裹窗口
 *
 *
 */
public class WndBag extends WndTabbed {
    private const SIZE:int = 58;
    public var equitLayout:GridLayoutSprite = new GridLayoutSprite(SIZE, 5);
    public var containerLayout:GridLayoutSprite = new GridLayoutSprite(SIZE, MAXSIZE);
    public static var MAXSIZE:int = 20;
    private var selectCell:ItemSlot;

    public function WndBag() {
        super();
        equitLayout.x = 4;
        equitLayout.y = 20;
        addChild(equitLayout);
        //1武器//2装备//3 技能 4//技能//5 道具
        for (var i:int = 0; i < 5; i++) {
            //var itemSlot:ItemSlot = new ItemSlot();
        }
        //
        containerLayout.x = 4;
        containerLayout.y = 80;
        addChild(containerLayout);
        //
        placeItemsBag();
        //
        addEventListener(ItemEvent.ITEM_CLICK, onItemClick);
        Dungeon.hero.belongings.backpack.signal.add(onItemHandle);
    }

    /**
     * 听得事件
     * @param eventType
     * @param item
     */
    private function onItemHandle(eventType:String, item:Item, index:int):void {
        if (eventType == Bag.REMOVE_ITEM) {
            trace("移除道具");
            containerLayout.removeFromLayOut(item, index);

        } else if (eventType == Bag.ADD_ITEM) {

            containerLayout.insetItemSolt(item, index);
            trace("添加道具", index);
        }
    }

    override public function creatCloseBotton():void {
        super.creatCloseBotton();
        //
        var btn:Button = DebugTool.makeButton("close");
        btn.addEventListener(Event.TRIGGERED, onClose);
        backGroundview.addChild(btn);
        btn = DebugTool.makeButton("装备");
        btn.addEventListener(Event.TRIGGERED, onEquitClick);
        btn.x = 50;
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("使用");
        btn.x = 100;
        btn.addEventListener(Event.TRIGGERED, onUseClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("卸下");
        btn.x = 150;
        btn.addEventListener(Event.TRIGGERED, onUnEquitClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("卖出");
        btn.x = 200;
        btn.addEventListener(Event.TRIGGERED, onSellClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("丢弃");
        btn.x = 250;
        btn.addEventListener(Event.TRIGGERED, onDropClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("整理包裹");
        btn.x = 300;
        btn.addEventListener(Event.TRIGGERED, onZhengLiClick);
        backGroundview.addChild(btn);
    }

    private function onZhengLiClick(event:Event):void {
        containerLayout.rescroe();
    }

    public function getIndexByType(item:Item):int {
        var belong:Belongings = Dungeon.hero.belongings;
        if (belong.weapon == item) {
            return 0;
        }
        if (belong.armor == item) {
            return 1;
        }
        if (belong.misc1 == item) {
            return 2;
        }
        if (belong.misc2 == item) {
            return 3;
        }
        return -1;
    }

    protected function onEquitClick(event:Event):void {
        if (selectCell.item is EquipableItem) {
            var item:EquipableItem = selectCell.item as EquipableItem;
            var cell:Item = containerLayout.getItem(selectCell.item);
            if (cell) {
                //道具装备的时候 包含了数据移除功能
                if (item.doEquip(Dungeon.hero)) {
                    var itemSeat:int = getIndexByType(item);
                    //下层包裹移除
                    containerLayout.removeFromLayOut(item);


                    trace(containerLayout.dataArray);
                    //上层装备层也移除已装备的 抛出这个移除装备
                    var returnItem:Item = equitLayout.dataArray[itemSeat] as Item;
                    if (returnItem != null) {
                        trace("上层卸载老的装备");
                        equitLayout.removeFromLayOut(returnItem);
                        containerLayout.insetItemSolt(returnItem);
                    }
                    //
                    equitLayout.insetItemSolt(item, itemSeat);
                    trace("上层包裹装入新的装备");

                    //
                    selectCell.unSelect();
                    selectCell = null;

                    trace(containerLayout.dataArray);

                } else {
                    trace("装备失败");
                }

            } else {
                trace("装备必须在包裹内的下层");
            }
        }
    }

    protected function onUseClick(event:Event):void {
        if (selectCell && selectCell.item) {
            selectCell.item.execute(Dungeon.hero, null);
        }
    }

    protected function onUnEquitClick(event:Event):void {
        var item:EquipableItem = getEquipableItem();
        if (item) {
            //var itemSeat:int = getIndexByType(item);
            if (item.doUnequip(Dungeon.hero)) {
                //如果解除成功
                equitLayout.removeFromLayOut(item);
                //
                containerLayout.insetItemSolt(item);

                //
                selectCell.unSelect();
                selectCell = null;
            }
        }
    }

    protected function getEquipableItem():EquipableItem {
        if (selectCell && selectCell.item) {
            var item:EquipableItem = selectCell.item as EquipableItem;
            return item;
        }
        return null;
    }

    protected function onSellClick(event:Event):void {
        if (selectCell && selectCell.item) {
            sellItem(selectCell.item);
        }
    }

    protected function onDropClick(event:Event):void {
        if (selectCell && selectCell.item) {
            sellItem(selectCell.item);
        }
    }

    protected function onItemClick(event:ItemEvent):void {

        if (selectCell) {
            selectCell.unSelect();
        }
        selectCell = event.data as ItemSlot;
        selectCell.select();
        showItemInfo(selectCell);
        //
        trace("selectCell is ", selectCell);
    }

    /**
     * 展示道具信息
     * @param item
     */
    public function showItemInfo(item:ItemSlot):void {

    }

    /**
     * 丢弃道具
     * @param item
     */
    public function dorpItem(item:Item):void {
        containerLayout.removeFromLayOut(item);
    }

    /**
     * 卖道具
     * @param item
     */
    public function sellItem(item:Item):void {
        containerLayout.removeFromLayOut(item);
        selectCell = null;
        trace("卖出成功.");
    }

    public function placeItemsBag():void {
        var items:Vector.<Bundlable>;
        items = Dungeon.hero.belongings.backpack.items;
        containerLayout.setDataArray(items);
        var equitItems:Vector.<Bundlable> = Dungeon.hero.belongings.backpack.equitItems;
        equitLayout.setDataArray(equitItems);

    }

    override public function selectTab(tab:Tab):void {
        super.selectTab(tab);
    }

}
}
