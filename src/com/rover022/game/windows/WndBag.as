package com.rover022.game.windows {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.hero.Belongings;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.events.ItemEvent;
import com.rover022.game.items.EquipableItem;
import com.rover022.game.items.Item;
import com.rover022.game.items.KindofMisc;
import com.rover022.game.items.armor.Armor;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.items.weapon.Weapon;
import com.rover022.game.ui.ItemSlot;
import com.rover022.game.utils.DebugTool;
import com.rover022.game.windows.wnditems.BagCellListener;
import com.rover022.game.windows.wnditems.GridLayoutSprite;
import com.rover022.game.windows.wnditems.Listener;
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
    public var bagListener:Listener = new BagCellListener();

    public var equitLayout:GridLayoutSprite = new GridLayoutSprite(SIZE, 5);
    public var containerLayout:GridLayoutSprite = new GridLayoutSprite(SIZE, 5);
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
        placeItemsBag();
        //
        addEventListener(ItemEvent.ITEM_CLICK, onItemClick);

    }

    override public function creatCloseBotton():void {
        super.creatCloseBotton();
        //
        var btn:Button = DebugTool.makeButton("close");
        btn.addEventListener(Event.TRIGGERED, onClose);
        backGroundview.addChild(btn);
        btn = DebugTool.makeButton("装备");
        btn.addEventListener(Event.TRIGGERED, onEquitClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("使用");
        btn.addEventListener(Event.TRIGGERED, onUseClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("卸下");
        btn.addEventListener(Event.TRIGGERED, onUnEquitClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("卖出");
        btn.addEventListener(Event.TRIGGERED, onSellClick);
        backGroundview.addChild(btn);

        btn = DebugTool.makeButton("丢弃");
        btn.addEventListener(Event.TRIGGERED, onDropClick);
        backGroundview.addChild(btn);
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
        var item:EquipableItem = getEquipableItem();
        if (item) {
            if (containerLayout.contains(item)) {
                //道具装备的时候 包含了数据移除功能
                if (item.doEquip(Dungeon.hero)) {
                    var itemSeat:int = getIndexByType(item);
                    //下层包裹移除
                    containerLayout.removeItemSolt(selectCell);
                    //上层装备层也移除已装备的 抛出这个移除装备
                    var returnItem:ItemSlot = equitLayout.getItemSolt(itemSeat);
                    if (returnItem) {
                        containerLayout.addItemSolt(returnItem);
                    }
                    //
                    selectCell.unSelect();
                    selectCell = null;
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
            var itemSeat:int = getIndexByType(item);
            if (item.doUnequip(Dungeon.hero)) {
                //如果解除成功
                equitLayout.removeItemSolt(selectCell);
                //
                containerLayout.addItemSolt(selectCell);
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
            selectCell.item.doSell(Dungeon.hero)
        }
    }

    protected function onDropClick(event:Event):void {
        if (selectCell && selectCell.item) {
            selectCell.item.doDrop(Dungeon.hero)
        }
    }

    protected function onItemClick(event:ItemEvent):void {
        trace(event.data, "onClick");
        if (selectCell) {
            selectCell.unSelect();
        }
        selectCell = event.data as ItemSlot;
        selectCell.select();
        showItemInfo(selectCell);
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
    public function dorpItem(item:ItemSlot):void {

    }

    /**
     * 卖道具
     * @param item
     */
    public function sellItem(item:ItemSlot):void {

    }

    /**
     * 装备道具
     * @param item
     */
    public function doEquit(item:ItemSlot):void {

    }

    public function placeTitle(src:Bag, index:int):void {

    }

    public function placeItemsBag():void {
        for each (var item:Item in Dungeon.hero.belongings.backpack.items) {
            placeItem(item);
        }
    }

    public function placeItem(item:Item):void {
        if (containerLayout.numChildren < MAXSIZE) {
            containerLayout.add(new ItemSlot(item));
        }
    }

    override public function selectTab(tab:Tab):void {
        super.selectTab(tab);
    }

}
}
