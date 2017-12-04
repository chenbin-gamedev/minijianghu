package com.rover022.game.items {
import com.rover022.game.actors.Char;
import com.rover022.game.items.weapon.Weapon;
import com.rover022.game.utils.RandomeUtil;

public class KindOfWeapon extends EquipableItem {
    public function KindOfWeapon() {
        super();
    }

    public function proc( attacker:Char, defender:Char, damage:int):int {
        return damage;
    }

    public function min(lvl:int):int {
        return lvl;
    }

    public function max(lvl:int):int {
        return lvl;
    }

    public function damageRoll(owner:Char):int {
        return RandomeUtil.normalIntRange(1, 1);
    }

    public function accuracyFactor(owner:Char):Number {
        return 1;
    }

    public function speedFactor(owner:Char):Number {
        return 1;
    }

    public function reachFactor(owner:Char):int {
        return 1
    }

    public function defenseFactor(owener:Char):int {
        return 0;
    }
}
}
