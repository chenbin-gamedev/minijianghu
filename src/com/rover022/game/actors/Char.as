package com.rover022.game.actors {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.actors.buffs.Buff;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

public class Char extends Actor {

    public var pos:Point = new Point();
//    public var sprite:CharSprite;
//    public var name:String = "mod";

    //优先级
    public var actPriority:int;
    public var HT:int;
    public var HP:int;
    public var SHLD:int;
    public var attackSkill:int;
    public var defenseSkill:int;
    public var baseSpeed:Number = 1;
    public var path:Array;
    //发呆
    public var paralused:int = 0;
    public var rooted:Boolean = false;
    public var flying:Boolean = false;
    //敌人
    public static var ENEMY:String = "ENEMY";
    //中立
    public static var NEUTRAL:String = "NEUTRAL";
    //盟友
    public static var ALLY:String = "ALLY";

    public var alignment:String = NEUTRAL;

    public var buffs:Array = [];

    public function Char() {
        pos = new Point();
        initDrawDebug();
    }

    protected function initDrawDebug():void {
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(SIZE, 0xff00ff));
        }
    }

    public function attack(enemy:Char):Boolean {
        return true;
    }

    public function attackProc(enemy:Char, damage:int):int {
        return 0;
    }

    public function defenseProc(enemy:Char, damage:int):int {
        return 0;
    }

    public function damage(dmg:int, src:Object):void {
        if (!isAlive() || dmg < 0) {
            return;
        }

    }

    override public function addBuff(buff:Buff):void {
        buffs.push(buff);
    }

    override public function removeBuff(buff:Buff):void {
        var _index:Number = buffs.indexOf(buff);
        if (_index != -1) {
            buffs.removeAt(_index);
        }
    }

    override public function onRemove():void {
        super.onRemove()
        for each (var buff:Buff in buffs) {
            buff.deach();
        }
    }

    public function updateSpriteState():void {
        for each (var buff:Buff in buffs) {
            buff.fx(true);
        }
    }

    public function destroy():void {
        HP = 0;
        Actor.remove(this);
    }

    public function isAlive():Boolean {
        if (HP > 0) {
            return true;
        }
        return false;
    }

    public function move(sept:int):void {

    }

    public function distance(other:Char):int {
        return MiniGame.distance(pos, other.pos);
    }

    public function onAttackComplete():void {
        next();
    }

    public function onOperateComplete():void {
        next();
    }

    public function storeInBundle():void {

    }

    public function immunities():Array {
        return buffs;
    }
}
}
