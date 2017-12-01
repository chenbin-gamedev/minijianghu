package com.rover022.game.actors {
import com.rover022.game.actors.buffs.Buff;
import com.rover022.game.actors.mobs.Mob;

import starling.display.Sprite;

public class Actor extends Sprite {
    public static var TICK:Number = 1;
    public var time:Number;
    public var id:int = 0;

    public function Actor() {
        super();
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
}
}
