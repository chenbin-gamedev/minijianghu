package com.rover022.game.items.weapon.enchantments {
import com.rover022.game.actors.Char;
import com.rover022.game.items.weapon.Weapon;

/**
 * 装备前面的词缀
 */
public class Enchantment {

    public function Enchantment() {
    }

    public function proc(weapon:Weapon, attacker:Char, defender:Char, damage:int):int {
        return 0;
    }
}
}
