package com.rover022.game.items {
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;

/**
 * 虚拟类
 * 装备道具类
 */
public class EquipableItem extends Item {
    public static const AC_EQUIP:String = "EQUIP";
    public static const AC_UNEQUIP:String = "UNEQUIP";

    public function EquipableItem() {
        super();
    }


    override public function actions():Array {
        return [AC_UNEQUIP, AC_EQUIP];
    }

    public static function equipCursed(hero:Hero):void {

    }

    public function time2equip(hero:Hero):Number {
        return 1;
    }

    public function doEquip(hero:Hero):Boolean {
        return true;
    }

    override public function cast(hero:Hero, dst:int):void {
        super.cast(hero, dst);
    }

    /**
     * 解除
     * @param hero
     * @param collect
     * @return
     */
    public function doUnequip(hero:Hero, collect:Boolean):Boolean {
        return doUnequip(hero, collect);
    }

    public function active(ch:Char):void {

    }
}
}
