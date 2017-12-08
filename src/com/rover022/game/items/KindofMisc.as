package com.rover022.game.items {
import com.rover022.game.actors.hero.Hero;

public class KindofMisc extends EquipableItem {
    public function KindofMisc() {
        super();
    }

    override public function doEquip(hero:Hero):Boolean {

        if (hero.belongings.misc1 == null) {
            hero.belongings.misc1 = this;
        } else {
            hero.belongings.misc2 = this;
        }
        return true;
    }

    override public function doUnequip(hero:Hero, b1:Boolean = false, b2:Boolean = false):Boolean {

        if (hero.belongings.misc1 == this) {
            hero.belongings.misc1 = null;
        } else {
            hero.belongings.misc2 = null;
        }
        return true;
    }

    override public function getIndex(hero:Hero):int {
        if (hero.belongings.misc1 == this) {
            hero.belongings.misc1 = null;
        } else {
            hero.belongings.misc2 = null;
        }

        return super.getIndex(hero);
    }
}
}
