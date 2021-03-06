package com.rover022.game.items {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;

/**
 * 虚拟类
 * 可装备, 可道具类
 */
public class EquipableItem extends Item {
    public static const AC_EQUIP:String = "EQUIP";
    public static const AC_UNEQUIP:String = "UNEQUIP";
    public var parentVarName:String;

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

    public function doUnequip(hero:Hero, b1:Boolean = false, b2:Boolean = false):Boolean {
        Dungeon.quickslot.clearItem(this);
        updateQuickslot();
        return true;
    }

    override public function cast(hero:Hero, dst:int):void {
        super.cast(hero, dst);
    }

    public function active(ch:Char):void {

    }

    public function getIndex(hero:Hero):int {
        return -1;
    }
}
}
