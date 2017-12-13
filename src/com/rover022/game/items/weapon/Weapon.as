package com.rover022.game.items.weapon {
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
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

    override public function doUnequip(hero:Hero, b1:Boolean = false, b2:Boolean = false):Boolean {
        if (hero.belongings.weapon == this) {
            hero.belongings.weapon = null;
            return true;
        } else {
            return false;
        }
    }

    override public function doEquip(hero:Hero):Boolean {
        if (hero.belongings.weapon != this) {
            if (hero.belongings.weapon) {
                hero.belongings.weapon.doUnequip(hero);
            }
            hero.belongings.weapon = this;
            return true;
        } else {
            return false;
        }
    }
}
}
