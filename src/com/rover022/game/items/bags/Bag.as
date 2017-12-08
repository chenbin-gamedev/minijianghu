package com.rover022.game.items.bags {
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.Item;
import com.rover022.game.utils.Bundle;

public class Bag extends Item {
    public static var AC_OPEN:String = "OPEN";
    public var items:Array = [];
    public var size:int = 1;
    public var owner:Char;

    private static const ITEMS:String = "inventory";

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

    public function addItem(item:Item):void {
        if (items.indexOf(item) == -1) {
            items.push(items);
        }
    }

    public function remove(item:Item):void {

    }

    /**
     * @inheritDoc
     * @param src
     */
    override public function storeInBundle(bundle:Bundle):void {
        super.storeInBundle(bundle);
        bundle.putBundleList(ITEMS, items)
    }

    /**
     * @inheritDoc
     * @param src
     */
    override public function restoreFromBundle(bundle:Bundle):void {
        super.restoreFromBundle(bundle);
        var array:Array = bundle.getBundlableList(ITEMS);
        for (var i:int = 0; i < array.length; i++) {
            var item:Item = array[i] as Item;
            if (item != null) {
                //道具一个一个被装进包裹
                item.collect(this);
            } else {
                trace("道具没有转化成功");
            }
        }
    }
}
}
