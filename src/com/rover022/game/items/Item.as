package com.rover022.game.items {
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.scenes.GameScene;

import flash.geom.Point;

public class Item {
    public var curUSer:Hero;
    public var curItem:Item;
    public var defaultAction:String;
    public var usesTargeting:Boolean;
    public const TIME_TO_THROW:Number = 1;
    public const TIME_TO_PICK_UP:Number = 1;
    public const TIME_TO_DROP:Number = 1;
    //放下
    public const AC_DROP:String = "DORP";
    //扔
    public const AC_THROW:String = "THROW";
    //可堆叠
    public var stackable:Boolean = false;
    //数量
    public var quantity:int = 1;
    //等级
    public var level:int;
    //可否升级
    public var levelKnown:Boolean = false;
    //诅咒
    public var cursed:Boolean;
    //可否诅咒
    public var cursedKnown:Boolean;
    //独一无二
    public var unique:Boolean = false;
    public var bones:Boolean = false;
    //出现的坐标点
    public var pos:Point;

    public function Item() {
    }

    public function getLevel():Number {
        return level;
    }

    public function actions():Array {
        return [AC_DROP, AC_THROW];
    }

    public function doPickUp(hero:Hero):Boolean {
        if (collect(hero.belongings.backpack)) {
            GameScene.pickUp(this, hero.pos);
            hero.spendAndNext(TIME_TO_PICK_UP);
            return true;
        }
        return false;
    }

    public function doDrop(hero:Hero):void {

    }

    public function visiblyUpgradoble():int {
        return levelKnown ? level : 0;
    }

    public function visiblyCursed():Boolean {
        return cursed && cursedKnown;
    }

    /**
     * 是否可以成长型装备
     */
    public function isUpgradoble():Boolean {
        return true;
    }

    /**
     * 是否被鉴定的
     * @return
     */
    public function isIdentified():Boolean {
        return levelKnown && cursedKnown;
    }

    /**
     * 是否被装备的
     * @param hero
     * @return
     */
    public function isEquipped(hero:Hero):Boolean {
        return false;
    }

    public function reset():void {

    }

    public function doThrow(hero:Hero):void {
//        GameScene.selectCall(thrower);
    }

    public function execute(hero:Hero, action:String):void {
        curUSer = hero;
        curItem = this;
        if (action == AC_DROP) {
            doDrop(hero);
        } else if (action == AC_THROW) {
            doThrow(hero);
        }
    }

    /**
     * 是否包含这个
     * @param container
     * @return
     */
    public function collect(container:Bag):Boolean {
        var items:Vector.<Item> = container.items;
        if (items.indexOf(this) != -1) {
            return true;
        }

        if (stackable) {
            for each (var item:Item in items) {
                if (isSimilar(item)) {
                    item.quantity += quantity;
                    item.updateQuickslot();
                    return true
                }
            }
        }

        return false;
    }

    private function isSimilar(item:Item):Boolean {
        return true;
    }

    /**
     * 刷新快捷插槽
     */
    public function updateQuickslot():void {

    }

    public function cast(hero:Hero, dst:int):void {

    }
}
}
