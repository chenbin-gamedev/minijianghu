package com.rover022.game.items {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;

import flash.geom.Point;
import flash.utils.getQualifiedClassName;

import starling.display.Sprite;

public class Item extends Sprite implements Bundlable {
    //药水
    public static const TYPE_POTION:String = "TYPE_POTION";
    //食物
    public static const TYPE_FOOD:String = "TYPE_FOOD";
    //装备
    public static const TYPE_WEAPON:String = "TYPE_WEAPON";
    //金钱
    public static const TYPE_GOLD:String = "TYPE_GOLD";
    //
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

    /**
     * 道具被拾起
     * 如果道具被装载进了英雄的包裹
     * 道具显示元素不需要自己再次移除了
     * @param hero
     * @return
     */
    public function doPickUp(hero:Hero):Boolean {
        if (collect(hero.belongings.backpack)) {
            var index:int = Dungeon.level.blobs.indexOf(this);
            if (index != -1) {
                Dungeon.level.blobs.removeAt(index);
            }
            //
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
     * 把道具甩到这个坐标点去
     * @param user
     * @param dst
     */
    public function throwPos(user:Hero, dst:Point):void {

    }

    public function onThrow(_pos:Point):void {

    }

    /**
     * 用英雄的包包去装载这个道具
     * 如果成功返回true
     *
     * @param container
     * @return
     */
    public function collect(container:Bag):Boolean {
        var items:Vector.<Item> = container.items;

        if (items.indexOf(this) != -1) {
            //如果再次包含这个道具直接放回
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
        if (items.length < container.size) {
            items.push(this);
            Dungeon.quickslot.replacePlaceholder(this);
            updateQuickslot();
            return true;
        }
        return false;
    }

    public function isSimilar(item:Item):Boolean {
        return getQualifiedClassName(item) == getQualifiedClassName(this);
    }

    /**
     * 刷新快捷插槽
     */
    public function updateQuickslot():void {

    }

    public function cast(hero:Hero, dst:int):void {

    }

    /**
     * 鉴定
     * @return
     */
    public function identify():Item {
        levelKnown = true;
        cursedKnown = true;
        if (Dungeon.hero != null && Dungeon.hero.isAlive()) {

        }
        return this;
    }

    public function restoreFromBindle(src:Bundle):void {
    }

    public function storeInBundle(src:Bundle):void {
    }
}
}
