package com.rover022.game.items {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.bags.Bag;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.tiles.DungeonTilemap;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;
import com.rover022.game.utils.DebugTool;
import com.rover022.game.utils.TweenUtils;

import flash.geom.Point;
import flash.utils.getQualifiedClassName;

import starling.animation.Transitions;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

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

    private static const QUANTITY:String = "quantity";
    private static const LEVEL:String = "level";
    private static const LEVLE_KNOWN:String = "levelKnown";
    private static const CURSED:String = "cursed";
    private static const CURSED_KNOW:String = "cursedKnown";

    //
    //public const TIME_TO_THROW:Number = 1;
    //public const TIME_TO_PICK_UP:Number = 1;
    //public const TIME_TO_DROP:Number = 1;
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
//        initDrawDebug();
        addEventListener(Event.ADDED_TO_STAGE, onCreate);
    }

    private function onCreate(event:Event):void {
        initDrawDebug();
    }

    protected function initDrawDebug():void {
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(30, 0x00ff00));
            var _name:String = getQualifiedClassName(this);
            var _nameArray:Array = _name.split(".");

            var text:TextField = new TextField(44, 20, _nameArray[_nameArray.length - 1]);
            addChild(text);
        }
    }

    public function getLevel():Number {
        return level;
    }

    public function actions():Array {
        return [AC_DROP, AC_THROW];
    }

    /**
     * 道具被拾起
     * 检查道具被装进口袋逻辑
     * 如果道具被装载进了英雄的包裹
     * 道具显示元素不需要自己再次移除了
     * @param hero
     * @return
     */
    public function doPickUp(hero:Hero):Boolean {
        if (collect(hero.belongings.backpack)) {
            //清理地面
            var index:int = Dungeon.level.blobs.indexOf(this);
            if (index != -1) {
                Dungeon.level.blobs.removeAt(index);
            }
            //播放收取道具动画;
            TweenUtils.move(this, new Point(0, 0), Transitions.EASE_IN_BACK);
            GameScene.pickUp(this, hero.pos);
//            hero.spendAndNext(TIME_TO_PICK_UP);
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

    public function reset():Boolean {
        x = DungeonTilemap.SIZE * pos.x;
        y = DungeonTilemap.SIZE * pos.y;
        return true;
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
     * @param user 使用这个武器者
     * @param dst  目标坐标点
     */
    public function throwPos(user:Char, dst:Point):void {

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
        var items:Array = container.items;

        if (items.indexOf(this) != -1) {
            //如果再次包含这个道具直接放回 一般不会这样
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
        //如果包裹还有空间
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

    public function restoreFromBundle(bundle:Bundle):void {
        bundle.put(QUANTITY, quantity);
        bundle.put(LEVEL, level);
        bundle.put(LEVLE_KNOWN, levelKnown);
        bundle.put(CURSED, cursed);
        bundle.put(CURSED_KNOW, cursedKnown);

    }

    public function storeInBundle(bundle:Bundle):void {
        quantity = bundle.getInt(QUANTITY);
        level = bundle.getInt(QUANTITY);
        levelKnown = bundle.getBoolean(LEVLE_KNOWN);
        cursed = bundle.getBoolean(CURSED);
        cursedKnown = bundle.getBoolean(CURSED_KNOW);
    }

    public function doSell(hero:Hero):void {
        doDrop(hero);
    }
}
}
