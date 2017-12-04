package com.rover022.game.items.weapon.enchantments {
import com.rover022.game.actors.Char;
import com.rover022.game.items.weapon.Weapon;
import com.rover022.game.sprites.CharSprite;

/**
 * 吸血
 */
public class Vampiric extends Enchantment {
    public function Vampiric() {
        super();
    }

    override public function proc(weapon:Weapon, attacker:Char, defender:Char, damage:int):int {
        var level:int = Math.max(0, weapon.getLevel());
        //lvl 0 - 16%
        //lvl 1 - 17.65%
        //lvl 2 - 19.23%
        var maxValue:int = Math.round(damage * (level + 8) / level + 50);
        var effValue = Math.min(int(Math.random() * maxValue), attacker.HT - attacker.HP);
        if (effValue > 0) {
            attacker.HP += effValue;
            attacker.showStatus(CharSprite.POSITIVE, effValue);
        }
        return damage;
    }
}
}
