package com.rover022.game.items.weapon {
import com.rover022.game.actors.Char;
import com.rover022.game.items.KindOfWeapon;
import com.rover022.game.items.weapon.enchantments.Enchantment;

public class Weapon extends KindOfWeapon {

    //词缀
    public var enchantment:Enchantment;

    public function Weapon() {
    }

    override public function proc(attacker:Char, defender:Char, damage:int):int {
        if (enchantment != null) {
            damage = enchantment.proc(this, attacker, defender, damage);
        }
        return damage;
    }
}
}
