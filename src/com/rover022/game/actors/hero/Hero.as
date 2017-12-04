package com.rover022.game.actors.hero {
import com.rover022.game.Dungeon;
import com.rover022.game.MovieClipSample;
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.mobs.npcs.NPC;
import com.rover022.game.items.Item;
import com.rover022.game.items.KindOfWeapon;
import com.rover022.game.items.weapon.missiles.MissileWeapon;
import com.rover022.game.messages.Messages;
import com.rover022.game.sprites.CharSprite;

import flash.geom.Point;

import starling.animation.DelayedCall;
import starling.animation.Tween;
import starling.core.Starling;

public class Hero extends Char {
    public static const MAX_LEVEL:int = 99;
    public static const ATTACK:String = "attackSkill";
    public static const DEDENSE:String = "defenseSkill";
    public static const STRENGTH:String = "STR";
    public static const LEVEL:String = "leve";
    public static const EXPERIENCE:String = "exp";
    public static const HTBOOST:String = "htboost";

    public var curAction:HeroAction;
    public var lastAction:HeroAction;

    //
    public var STR:int;
    public var lvl:int = 1;
    public var exp:int = 0;
    public var HTBoost:int = 0;
    public var visibleEnemies:Array = [];
    public var midVisionEnemies:Array = [];
    public var belongings:Belongings;
    public var resting:Boolean;
    public var heroClass:HeroClass;
    private var rangeWeapon:MissileWeapon;

    public function Hero() {
        super();
        attackSkill = 10;
        defenseSkill = 5;
        belongings = new Belongings(this);
        visibleEnemies = [];
    }

    public function earnExp(_exp:int):void {
        exp += _exp;
        var percent:Number = _exp / maxExp;
        var levelup:Boolean = false;
        while (this.exp >= maxExp) {
            this.exp -= maxExp;
            if (lvl < MAX_LEVEL) {
                lvl++;
                levelup = true;
                //血量恢复
                updateHT(true);
                attackSkill++;
                defenseSkill++;
            } else {
                this.exp = 0;
                trace(Messages.get(this, "level_cap"));

            }
        }
        if (levelup) {
            trace(Messages.get(this, "new_level"));
            showState(CharSprite.POSITIVE, Messages.get(this, "level_up"));
            MovieClipSample.play("SND_LEVELUP");
        }
    }

    public function showState(POSITIVE:String, s:String):void {

    }

    public function get maxExp():int {
        return 5 + lvl * 5;
    }

    public function spendAndNext(time:Number):void {
        busy();
        spend(time);
        next();
    }

    private function busy():void {
        ready = false;
    }

    public function live():void {

    }

    public function resurrect(depth:int):void {

    }

    public function updataeArmor():void {

    }

    public function handle(cell:Point):Boolean {
        if (cell == null) {
            return false;
        }
        if (cell.x == pos.x && cell.y == pos.y) {
            return false;
        }
        var ch:Char;
        var item:Item;
        var blob:Blob;
        blob = Dungeon.level.findBlob(cell);
        if (blob) {
            return false;
        }
        ch = Dungeon.level.findMod(cell);
        if (ch) {
            if (ch is NPC) {
                curAction = new HeroAction(HeroAction.Interact, cell);
                curAction.target = ch;
            } else {
                if (canAttack(ch)) {
                    curAction = new HeroAction(HeroAction.Attack, cell);
                    curAction.target = ch;
                    return act();
                }
            }
        }
        item = Dungeon.level.findItem(cell);
        if (item) {
            curAction = new HeroAction(HeroAction.PickUp, cell);
            return act();
        }
        //移动逻辑
        if (cell == Dungeon.level.exit && Dungeon.depth < 26) {
            curAction = new HeroAction(HeroAction.Descend, cell);
        } else {
            curAction = new HeroAction(HeroAction.Move, cell);
        }
        if (ready) {
            return act();
        }
        return false;
    }

    /**
     * 行动
     * @return
     */
    override public function act():Boolean {
        if (curAction == null) {
            if (resting) {
                //spend(TIME_TO_REST);
                next();
                return false;
            }
            //ready();
            return false;

        } else {
            //执行行动逻辑...行动完成之后跑Actor.process()
            Starling.juggler.delayCall(Actor.process, baseSpeed);
            resting = false;
            ready = false;
            if (curAction.type == HeroAction.Move) {
                return actMove(curAction);
            } else if (curAction.type == HeroAction.Interact) {
                return actInteract(curAction);
            } else if (curAction.type == HeroAction.Buy) {
                return actBuy(curAction);
            } else if (curAction.type == HeroAction.PickUp) {
                return actPickUp(curAction);
            } else if (curAction.type == HeroAction.OpenChest) {
                return actOpenChest(curAction);
            } else if (curAction.type == HeroAction.Unlock) {
                return actUnlock(curAction);
            } else if (curAction.type == HeroAction.Descend) {
                return actDescend(curAction);
            } else if (curAction.type == HeroAction.Ascend) {
                return actAscend(curAction);
            } else if (curAction.type == HeroAction.Attack) {
                return actAttack(curAction);
            } else if (curAction.type == HeroAction.Alchemy) {
                return actAlchemy(curAction);
            }
            return false;
        }
    }

    override public function attackProc(enemy:Char, damage:int):int {
        var wep:KindOfWeapon = rangeWeapon != null ? rangeWeapon : belongings.weapon;
        if (wep != null) {
            damage = wep.proc(this, enemy, damage);
        }
        return damage;
    }

    public function actAttack(action:HeroAction):Boolean {
        enemy = action.target;
        if (enemy.isAlive() && canAttack(enemy) && !isCharmedBy(enemy)) {
            //Invisibility.dispel();
            //spend(attackDelay());
            //sprite.attack(enemy.pos);

//            HeroClass.ROGUE
            //执行动画程序
            var tween:Tween;
            if (heroClass.type == HeroClass.WARRIOR) {
                tween = new Tween(this, baseSpeed);
                tween.moveTo(enemy.x, enemy.y);
                tween.reverse = true;
                tween.repeatCount = 2;
                Starling.juggler.add(tween);
            } else {
                shoot(enemy, null);
            }
            //完毕以后执行攻击动作
            var delayCall:DelayedCall = new DelayedCall(attack, baseSpeed, [enemy]);
            Starling.juggler.add(delayCall);
//            attack(enemy);
//            ready = true;
            return true;
        } else {
            trace("enemy isAlive ", enemy.isAlive());
            trace("canAttack ", canAttack(enemy));
            trace("isCharmedBy()", !isCharmedBy(enemy));
            trace("不能执行攻击动作");
            return false;
        }
//        return true;
    }

    private function actAlchemy(curAction:HeroAction):Boolean {
        return true;
    }

    private function actAscend(curAction:HeroAction):Boolean {
        return true;
    }

    private function actDescend(curAction:HeroAction):Boolean {
        return true;

    }

    private function actUnlock(curAction:HeroAction):Boolean {
        return true;
    }

    private function actOpenChest(curAction:HeroAction):Boolean {
        return true;
    }

    private function actPickUp(curAction:HeroAction):Boolean {
        return true;
    }

    private function actBuy(curAction:HeroAction):Boolean {
        return true;

    }

    /**
     * npc交谈
     * @param action
     * @return
     */
    private function actInteract(action:HeroAction):Boolean {
        var npc:NPC = action.target as NPC;
        npc.interact();
        return true;
    }

    override public function onCompleteTweener():void {
        ready = true;
    }

    override public function onCompleteAnimation():void {
        super.onCompleteAnimation();
    }

    private function actMove(action:HeroAction):Boolean {
        trace("移动");
        move(action.pos);
        return true;
    }

}
}
