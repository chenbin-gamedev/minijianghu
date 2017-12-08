package com.rover022.game.actors.hero {
import com.rover022.game.items.Item;
import com.rover022.game.items.KindOfWeapon;
import com.rover022.game.items.KindofMisc;
import com.rover022.game.items.armor.Armor;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;

public class Belongings implements Bundlable {
    public var backpack:Bag = new Bag();
    public static var BACKPACK_SIZE:int = 20;
    public var owner:Hero;
    //武器
    public var weapon:KindOfWeapon = null;
    //盔甲
    public var armor:Armor = null;
    //杂项1
    public var misc1:KindofMisc = null;
    //杂项2
    public var misc2:KindofMisc = null;

    private static const WEAPON:String = "weapon";
    private static const ARMOR:String = "armor";
    private static const MISC1:String = "misc1";
    private static const MISC2:String = "misc2";

    public function Belongings(hero:Hero) {
        this.owner = hero;
        backpack = new Bag();
        backpack.size = BACKPACK_SIZE;
        backpack.owner = owner;
    }

    public function getSimilar(similar:Item):Item {
        for each (var _item:Item in backpack.items) {
            if (_item.isSimilar(similar)) {
                return _item;
            }
        }
        return null;
    }

    public function identify():void {
        for each (var _item:Item in backpack.items) {
            _item.identify();
        }
    }

    public function observer():void {

    }

    public function randomUnequipped():Item {
        if (backpack.items.length > 0) {
            var _index:int = Math.random() * backpack.items.length;
            return backpack.items[_index];
        }
        return null;
    }

    /**
     * @inheritDoc
     * @param src
     */
    public function restoreFromBundle(bundle:Bundle):void {
        weapon = bundle.getBundle(WEAPON) as KindOfWeapon;
        armor = bundle.getBundle(ARMOR) as Armor;
        misc1 = bundle.getBundle(MISC1) as KindofMisc;
        misc2 = bundle.getBundle(MISC2) as KindofMisc;
        backpack.restoreFromBundle(bundle);
    }

    /**
     * @inheritDoc
     * @param src
     */
    public function storeInBundle(bundle:Bundle):void {

        bundle.put(WEAPON, weapon);
        bundle.put(ARMOR, armor);
        bundle.put(MISC1, misc1);
        bundle.put(MISC2, misc2);
        backpack.storeInBundle(bundle);
    }

    public function update():void {

    }
}
}
