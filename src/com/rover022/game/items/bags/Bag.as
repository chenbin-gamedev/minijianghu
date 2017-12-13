package com.rover022.game.items.bags {
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Belongings;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.Item;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;

import org.osflash.signals.Signal;

public class Bag extends Item {
    public static var AC_OPEN:String = "OPEN";

    public var equitItems:Vector.<Bundlable> = new Vector.<Bundlable>(5);
    public var items:Vector.<Bundlable> = new Vector.<Bundlable>(20);

    public var size:int = 1;
    public var owner:Char;
    private static const ITEMS:String = "inventory";
    private static const EQUITITEMS:String = "equititems";
    //
    public static const ADD_ITEM:String = "ADD_ITEM";
    public static const REMOVE_ITEM:String = "REMOVE_ITEM";
    //
    public var signal:Signal = new Signal(String, Item);

    public function Bag() {
        super();
        defaultAction = AC_OPEN;
    }

    override public function execute(hero:Hero, action:String):void {
        super.execute(hero, action);
    }

    override public function collect(src:Bag):Boolean {
        return super.collect(src);
    }

    /**
     * 包裹加入道具 看有空位就放入
     * @param item
     */
    public function addItem(item:Item):Boolean {
        for (var i:int = 0; i < items.length; i++) {
            if (items[i] == null) {
                items[i] = item;
                signal.dispatch(ADD_ITEM, item, i);
                return true;
            }
        }
        return false;
    }

    public function remove(item:Item):void {
        var index:int = items.indexOf(item);
        if (index == -1) {
            items[index] = null;
            signal.dispatch(REMOVE_ITEM, item, index);
        }
    }

    /**
     * @inheritDoc
     * @param src
     */
    override public function storeInBundle(bundle:Bundle):void {
        super.storeInBundle(bundle);
        bundle.putBundleListVector(ITEMS, items);
        bundle.putBundleListVector(EQUITITEMS, equitItems);
    }

    /**
     * @inheritDoc
     * @param src
     */
    override public function restoreFromBundle(bundle:Bundle):void {
        super.restoreFromBundle(bundle);
        items = new Vector.<Bundlable>(Belongings.BACKPACK_SIZE);
        equitItems = new Vector.<Bundlable>(5);
        var i:int;
        var array:Array = bundle.getBundlableList(ITEMS);
        for (i = 0; i < items.length; i++) {
            items[i] = array[i];
        }
        array = bundle.getBundlableList(EQUITITEMS);
        for (i = 0; i < equitItems.length; i++) {
            equitItems[i] = array[i];
        }
    }
}
}
