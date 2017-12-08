package com.rover022.game.items.armor {
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.EquipableItem;

/**
 * 铠甲
 */
public class Armor extends EquipableItem {
    public function Armor() {
        super();
    }

    override public function doUnequip(hero:Hero, b1:Boolean = false, b2:Boolean = false):Boolean {
        if (hero.belongings.armor == this) {
            hero.belongings.armor = null;
            return true;
        } else {
            return false;
        }
    }

    override public function doEquip(hero:Hero):Boolean {
        if (hero.belongings.armor != this) {
            hero.belongings.armor = this;
            return true;
        } else {
            return false;
        }
    }
}
}
