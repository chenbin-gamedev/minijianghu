package com.rover022.game.items {
import com.rover022.game.Dungeon;
import com.rover022.game.items.food.Food;
import com.rover022.game.items.potions.Potion;
import com.rover022.game.items.weapon.Weapon;
import com.rover022.game.items.weapon.melee.Sword;
import com.rover022.game.items.weapon.missiles.MissileWeapon;

import flash.utils.Dictionary;

/**
 * 道具随机掉落工厂类
 * 1 控制道具的掉落率
 * 2 预期值所有物品掉率累加是小于100% 产生结果 有的怪会掉落道具 有的不会掉落道具
 * 3 假设真实值 大于100% 产生结果是 这个怪物必定掉落道具 加权值为 所有怪物的百度比 累加
 * 4 游戏设计问题
 */
public class Generator {
    private static var top:Number;
    private static var dict:Dictionary;
    public static var GOLD_CLASS:Array = [Gold];
    public static var itemClass:ItemClass;

    public function Generator() {

    }

    /**
     *  随机掉宝
     *  可以能掉可能不掉
     *  和英雄的运气关联..
     * @return
     */
    public static function randomItem():Item {
        var luck:Number = 0.7;
        if (Dungeon.hero != null) {
            luck = Dungeon.hero.getLuck();
        }
        if (Math.random() < luck) {
            return randomItemAwaysHas();
        } else {
            return null;
        }
    }

    /**
     * 重置
     */
    public static function reset():void {
        dict = new Dictionary();
        top = 0;
        putNum(6, Item.TYPE_WEAPON);
        putNum(30, Item.TYPE_GOLD);
        putNum(20, Item.TYPE_FOOD);
        putNum(20, Item.TYPE_POTION);
        var min:Number = 0;
        for (var _name:String in dict) {
            var value:Number = dict[_name];
            dict[_name] = new MathObject(min, min + value, _name);
            min += value;
        }
        //初始化各种武器的爆率
        var _arr:Array = [MissileWeapon, Sword];
        var _cout:Array = [30, 40];
        itemClass = new ItemClass(_arr, _cout);
    }

    /**
     * 随机必掉道具
     * @return
     */
    public static function randomItemAwaysHas():Item {
        var num:Number = Math.random() * top;
        for each (var mathObject:MathObject in dict) {
            if (mathObject.contain(num)) {
                return randomCategory(mathObject.name);
            }
        }
        return null;
    }

    private static function putNum(_num:Number, _type:String):void {
        top += _num;
        dict[_type] = _num;
    }

    public static function initArtifacts():void {

    }

    /***
     * 根据标签掉落道具
     * @param type
     * @return
     */
    public static function randomCategory(type:String):Item {
        var item:Item;
        switch (type) {
            case Item.TYPE_GOLD:
                item = new Gold();
                break;
            case Item.TYPE_WEAPON:
                var _class:Class = itemClass.getRandom();
                item = new _class();
                break;
            case Item.TYPE_POTION:
                item = new Potion();
                break;
            case Item.TYPE_FOOD:
                item = new Food();
                break;
        }
        return item;
    }

    /**
     * 随机掉落一个装备类的道具
     * @return
     */
    public static function randomWeapon():Weapon {
        var _class:Class = itemClass.getRandom();
        var item:Weapon = new _class();
        return item;
    }
}
}

import flash.utils.Dictionary;

class MathObject {
    public var name:String;
    public var min:Number;
    public var max:Number;
    public var curClass:Class;

    public function MathObject(_min:Number, _max:Number, _object:String):void {
        min = _min;
        max = _max;
        name = _object;
    }

    public function contain(num:Number):Boolean {
        if (num >= min && num <= max) {
            return true;
        }
        return false;
    }
}

class ItemClass {

    private var dict:Dictionary;
    private var classArray:Array;
    private var countArray:Array;

    public function ItemClass(arr:Array, countArray:Array) {
        this.classArray = arr;
        this.countArray = countArray;
        reset();
    }

    public function reset():void {
        if (classArray.length != countArray.length) {
            throw (new Error(this + "设置的不对"));
        }
        dict = new Dictionary();
        var cur:Number = 0;
        var top:Number = getAllNumer(countArray);
        //
        for (var i:int = 0; i < classArray.length; i++) {
            var _class:Class = classArray[i];
            var min:Number = cur;
            var max:Number = cur + countArray[i] / top;
            var mathO:MathObject = new MathObject(min, max, "");
            mathO.curClass = _class;
            dict[_class] = mathO;
            cur += max;
        }
    }

    public function getRandom():Class {
        var _cur:Number = Math.random();
        for each (var mathObject:MathObject in dict) {
            if (mathObject.contain(_cur)) {
                return mathObject.curClass;
            }
        }
        return null;
    }

    public function dump():void {
        for each (var mathObject:MathObject in dict) {
            trace("name:", mathObject.curClass, "mini:", mathObject.min, "max:", mathObject.max);
        }
    }

    private function getAllNumer(countArray:Array):Number {
        var _num:Number = 0;
        for (var i:int = 0; i < countArray.length; i++) {
            _num += countArray[i];
        }
        return _num;
    }
}
