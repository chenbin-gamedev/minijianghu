package com.rover022.game.actors {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.actors.buffs.Buff;
import com.rover022.game.items.weapon.missiles.MissileWeapon;
import com.rover022.game.tiles.DungeonTilemap;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

import starling.animation.Tween;
import starling.core.Starling;
import starling.text.TextField;

public class Char extends Actor {
    public var enemy:Char;
    public var pos:Point = new Point();
    public var ready:Boolean = true;
    //幸运度
    protected var _luck:Number = 0.7;
//    public var sprite:CharSprite;
//    public var name:String = "mod";

    //优先级
    public var actPriority:int;
    //血量
    public var HP:int;
    //魔法
    public var HT:int;
    public var SHLD:int;
    //攻击力
    public var attackSkill:int;
    //防御力
    public var defenseSkill:int;
    //移动速度
    public var baseSpeed:Number = 0.5;
    //行走路径
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
    //角色阵营
    public var alignment:String = NEUTRAL;
    //
    public var buffs:Array = [];
    //皮肤UI
    public var HPTxt:TextField;
    public var HTTxt:TextField;
    public var ACKTxt:TextField;
    public var DEFTxt:TextField;
    public var imageUrl:String;

    public function Char() {
        pos = new Point();
        HP = 1;
        HT = 1;
        attackSkill = 1;
        defenseSkill = 0;
        initDrawDebug();
    }

    protected function initDrawDebug():void {
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(SIZE, 0xff00ff));
        }
        HPTxt = DebugTool.makeText(this, 14, 14, "1", 0, 0);
        HTTxt = DebugTool.makeText(this, 14, 14, "1", 30, 0);
        ACKTxt = DebugTool.makeText(this, 14, 14, "1", 0, 29);
        DEFTxt = DebugTool.makeText(this, 14, 14, "1", 30, 29);
        updateSpriteState()
    }

    public function updateSpriteState():void {
        for each (var buff:Buff in buffs) {
            buff.fx(true);
        }
        HPTxt.text = HP.toString();
        HTTxt.text = HT.toString();
        ACKTxt.text = attackSkill.toString();
        DEFTxt.text = defenseSkill.toString();
    }

    public function attack(enemy:Char):Boolean {
        if (enemy == null || !enemy.isAlive()) {

            return false;
        } else {
            var acuRoll:int = attackSkill;
            var defRoll:int = enemy.defenseSkill;
            var dmg:int = acuRoll - defRoll;
            dmg = attackProc(enemy, dmg)
            if (dmg < 0) {
                dmg = 0;
            }
            enemy.HP -= dmg;
            if (enemy.HP <= 0) {
                enemy.die();
            }
            trace("伤害值:", dmg, "剩余HP", enemy.HP);
            return enemy.HP <= 0;
            //hit(this, enemy, false);
        }

        return true;
    }

    /**
     * 返回是否死亡
     * @param attacker
     * @param defender
     * @param magic
     * @return
     */
    public static function hit(attacker:Char, defender:Char, magic:Boolean):Boolean {
        var acuRoll:int = attacker.attackSkill;
        var defRoll:int = defender.defenseSkill;
        var dmg:int = (acuRoll - defRoll);
        if (dmg < 0) {
            dmg = 0;
        }
        defender.HP -= dmg;
        if (defender.HP <= 0) {
            defender.die();
        }
        trace("伤害值:", dmg, "剩余HP", defender.HP);
        return defender.HP <= 0;
    }

    public function attackProc(enemy:Char, damage:int):int {
        return damage;
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
        super.onRemove();
        for each (var buff:Buff in buffs) {
            buff.deach();
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

    public function move(sept:Point):void {
        Dungeon.level.map[this.pos.x][this.pos.y] = 0;
        pos = sept;
        Dungeon.level.map[this.pos.x][this.pos.y] = 1;
        //
        var f_x:int = DungeonTilemap.SIZE * pos.x;
        var f_y:int = DungeonTilemap.SIZE * pos.y;
        var tween:Tween = new Tween(this, baseSpeed);
        tween.moveTo(f_x, f_y);
        tween.onComplete = onCompleteTweener;
        Starling.juggler.add(tween);
        //清理地图数据

    }

    public function shoot(enemy:Char, wep:MissileWeapon):Boolean {
        return true
    }

    public function updateHT(boostHP:Boolean):void {

    }

    /**
     * 判断能否被攻击
     * 1 活的
     * 2 没有被诱惑的
     * 3 在攻击范围之类的
     * @param enemy
     * @return
     */
    public function canAttack(enemy:Char):Boolean {
        if (enemy.isAlive() && !isCharmedBy(enemy) && getCloser(enemy.pos)) {
            return true;
        }
        return false;
    }

    /**
     * 判断这一点是否在攻击范围内
     * 先写一个基本的 上下左右
     * @param target
     * @return
     */
    public function getCloser(target:Point):Boolean {
        if (target.x == pos.x) {
            if (Math.abs(target.y - pos.y) == 1) {
                return true;
            }
        }
        if (target.y == pos.y) {
            if (Math.abs(target.x - pos.x) == 1) {
                return true;
            }
        }
        return false;
    }

    /**
     * 是否是被魔法迷了
     * @param enemy
     * @return
     */
    public function isCharmedBy(enemy:Char):Boolean {
        return false;
    }

    public function onCompleteTweener():void {

    }

    public function onCompleteAnimation():void {

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

    public function die():void {

    }

    public function showStatus(POSITIVE:String, effValue:Number):void {

    }

}
}
