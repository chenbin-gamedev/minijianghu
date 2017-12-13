package com.rover022.game.actors {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.buffs.Buff;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;

import de.polygonal.ds.Set;

import flash.geom.Point;

import starling.animation.DelayedCall;
import starling.core.Starling;
import starling.display.Sprite;

public class Actor extends Sprite implements Bundlable {
    public static var TICK:Number = 1;
    //回合数
    public static var now:int = 0;
    //行动的基本速度
    public var time:Number = gameSpeed;
    public var id:int = 0;
    public static var SIZE:int = 58;

    public static var all:Set = new Set();
    public static var chars:Set = new Set();
    public static var current:Char;
    //游戏时间 攻击速度
    public static var gameSpeed:Number = 0.5;
    private const TIME:String = "time";
    private const ID:String = "id";

    public function Actor() {
        super();
    }

    public function act():Boolean {
        return false;
    }

    /**
     * 地下城行动进度
     * 1 如果地下城没有敌对玩家那么可以再次行动
     * 2 如果地下城有敌人让敌人行动,0.5秒后玩家才可以行动
     */
    public static function process():void {
        var arr:Array = Dungeon.level.mobs;
        var passTime:Number = gameSpeed;
        var mob:Mob;
        for each (mob in arr) {
            mob.act();
            passTime = Math.max(mob.time, passTime);
        }
        mob = Dungeon.getFristMob();
        if (mob == null) {
            passTime = 0;
        }
        trace("AI行动经过时间:passTime:", passTime);
        var delayCall:DelayedCall = new DelayedCall(onMobProcessComplete, passTime);
        Starling.juggler.add(delayCall);

        function onMobProcessComplete():void {
            //添加回合数
            now++;
            //重置英雄功能
            Dungeon.hero.ready = true;
            Dungeon.hero.time = Actor.gameSpeed;
            trace("英雄ready is true");
        }
    }

    public function place(pos:Point):void {
        x = pos.x * SIZE;
        y = pos.y * SIZE;
    }

    public function next():void {

    }

    /**
     * 这次行动花费的时间
     * @param _time
     */
    public function spend(_time:Number):void {
        this.time = _time;
    }

    public function cooldown():void {

    }

    public function onAdd():void {

    }

    public function onRemove():void {

    }

    public function addBuff(buff:Buff):void {

    }

    public function removeBuff(buff:Buff):void {

    }

    /**
     * 添加演员
     * @param char
     */
    public static function add(char:Actor):void {
        //all.set(char);
        chars.set(char);
        char.onAdd();
//        Dungeon.level.mobs.push(char);
    }

    /**
     * 移除演员
     * @param char
     */
    public static function remove(char:Actor):void {
        chars.remove(char);
        char.onRemove();
    }

    public static function findById(_id:int):Actor {
        for each (var actor:Actor in chars) {
            if (actor.id == _id) {
                return actor;
            }
        }
        return null;
    }

    public static function init():void {
        add(Dungeon.hero);
        for each (var mob:Mob in Dungeon.level.mobs) {
            add(mob);
        }
        for each (var blob:Blob in Dungeon.level.blobs) {
            add(blob);
        }
        current = null;
    }

    public static function clear():void {
        chars = new Set();
    }

    public static function fixTime():void {

    }

    public static function resetNextID():void {

    }

    public static function addDelayed(mob:Mob, delay:Number):void {

    }

    /**
     * @inheritDoc
     * @param src
     */
    public function restoreFromBundle(bundle:Bundle):void {
        bundle.put(TIME, time);
        bundle.put(ID, id);
    }

    /**
     * @inheritDoc
     * @param src
     */
    public function storeInBundle(bundle:Bundle):void {
        time = bundle.getNumber(TIME)
        time = bundle.getInt(ID)
    }
}
}
