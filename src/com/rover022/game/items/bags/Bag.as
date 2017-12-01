package com.rover022.game.items.bags {
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.Item;

import flash.net.sendToURL;

public class Bag extends Item {
    public static var AC_OPEN:String = "OPEN";
    public var items:Vector.<Item> = new <Item>[];
    public var size:int = 1;
    public var owner:Char;

    public function Bag() {
        super();
        defaultAction = AC_OPEN;
    }

    override public function execute(hero:Hero, action:String):void {
        super.execute(hero, action);
    }

    override public function collect(src:Bag):Boolean {
        super .collect(src);
    }

}
}
