package com.rover022.game.actors.hero {
import com.rover022.game.items.armor.Armor;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.items.weapon.KindOfWeapon;
import com.rover022.game.items.weapon.KindofMisc;

public class Belongings {
    public var backpack:Bag = new Bag();
    public static var BACKPACK_SIZE:int = 20;
    public var owner:Hero;
    public var weapon:KindOfWeapon = null;
    //盔甲
    public var armor:Armor = null;
    //杂项1
    public var misc1:KindofMisc = null;
    //杂项2
    public var misc2:KindofMisc = null;

    public function Belongings(hero:Hero) {
        this.owner = hero;
        backpack = new Bag();
        backpack.size = BACKPACK_SIZE;
        backpack.owner = owner;
    }

}
}
