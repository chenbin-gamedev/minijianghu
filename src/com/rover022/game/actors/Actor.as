package com.rover022.game.actors {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.buffs.Buff;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;

import flash.geom.Point;

import starling.animation.DelayedCall;
import starling.core.Starling;
import starling.display.Sprite;

public class Actor extends Sprite implements Bundlable {
    public static var TICK:Number = 1;
    //回合数
    public static var now:int = 0;
    public var time:Number;
    public var id:int = 0;
    public static var SIZE:int = 58;

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
        var doNext:Boolean = true;
        for each (var mob:Mob in Dungeon.level.mobs) {
            mob.act();
            if (mob.alignment == Char.ENEMY) {
                doNext = false
            }
        }
        //
        if (doNext) {
            onMobProcessComplete();
        } else {
            var delayCall:DelayedCall = new DelayedCall(onMobProcessComplete, 0.5);
            Starling.juggler.add(delayCall);
        }

        function onMobProcessComplete():void {
            now++;
            Dungeon.hero.ready = true;
        }
    }

    public function place(pos:Point):void {
        x = pos.x * SIZE;
        y = pos.y * SIZE;
    }

    public function next():void {

    }

    public function spend(_time:Number):void {
        this.time += _time;
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

    }

    /**
     * 移除演员
     * @param char
     */
    public static function remove(char:Char):void {

    }

    public static function findById(_id:int):Actor {
        return null;
    }

    public static function clear():void {

    }

    public static function fixTime():void {

    }

    public static function resetNextID():void {

    }

    public static function addDelayed(mob:Mob, delay:Number):void {

    }

    public function restoreFromBindle(src:Bundle):void {
    }

    public function storeInBundle(src:Bundle):void {
    }
}
}
