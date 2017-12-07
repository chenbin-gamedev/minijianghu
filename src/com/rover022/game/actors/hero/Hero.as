package com.rover022.game.actors.hero {
import com.rover022.game.Dungeon;
import com.rover022.game.MovieClipSample;
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.mobs.npcs.NPC;
import com.rover022.game.items.Item;
import com.rover022.game.items.KindOfWeapon;
import com.rover022.game.messages.Messages;
import com.rover022.game.sprites.CharSprite;
import com.rover022.game.utils.Bundle;

import flash.geom.Point;

import starling.core.Starling;

public class Hero extends Char {
    public static const MAX_LEVEL:int = 99;
    //

    private static const STRENGTH:String = "STR";
    private static const LEVEL:String = "leve";
    private static const EXPERIENCE:String = "exp";
    private static const HTBOOST:String = "htboost";
    //
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

    public function Hero() {
        super();
        attackSkill = 10;
        defenseSkill = 5;
        belongings = new Belongings(this);
        visibleEnemies = [];
        //

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

    /**
     * 是否在上下左右格
     * 可以执行动作 对话 拾取
     * @param cell
     * @return
     */
    public function isRound(cell:Point):Boolean {
        if (cell.x == pos.x) {
            return Math.abs(cell.y - pos.y) == 1 ? true : false;
        }
        if (cell.y == pos.y) {
            return Math.abs(cell.x - pos.x) == 1 ? true : false;
        }
        return false;

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
                return act();
            } else {
                if (canAttack(ch)) {
                    curAction = new HeroAction(HeroAction.Attack, cell);
                    curAction.target = ch;
                    return act();
                } else {
                    return false;
                }
            }
        }
        item = Dungeon.level.findItem(cell);
        if (item) {
            if (isRound(cell)) {
                curAction = new HeroAction(HeroAction.PickUp, cell);
                curAction.item = item;
                return act();
            } else {
                return false;
            }
        }
        //移动逻辑
        if (cell == Dungeon.level.exit && Dungeon.depth < 26) {
            curAction = new HeroAction(HeroAction.Descend, cell);
        } else {
            curAction = new HeroAction(HeroAction.Move, cell);
        }

        return act();

    }

    /**
     * 战士打1格
     * 法师打2格
     * 流氓打3格
     * 猎人全屏
     * @param target
     * @return
     */
    override public function getCloser(target:Point):Boolean {
        if (heroClass.type == CharClass.WARRIOR) {
            return super.getCloser(target);
        } else if (heroClass.type == CharClass.MAGE) {
            var a:int = Math.abs(pos.x - target.x);
            var b:int = Math.abs(pos.y - target.y);
            if ((a + b) <= 2) {
                return true;
            }
            return false;
        } else if (heroClass.type == CharClass.ROGUE) {
            a = Math.abs(pos.x - target.x);
            b = Math.abs(pos.y - target.y);
            if ((a + b) <= 3) {
                return true;
            }
            return false;
        } else if (heroClass.type == CharClass.HUNTRESS) {
            return true;
        }
        return false;
    }

    /**
     * 行动
     * @return
     */
    override public function act():Boolean {
        if (ready == false) {
            trace("read is false");
            return false;
        }
        //
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
            trace("英雄执行动作", curAction.type);
            //50% time 次完成攻击计算
            //100% time 跑下一次逻辑
            //有攻击动作 +0.5秒(总1秒) 没有攻击动作就只有0.5秒;

            //Starling.juggler.delayCall(Actor.process, curAction.speedTime);
            resting = false;
            ready = false;
            var isState:Boolean = false;
            if (curAction.type == HeroAction.Move) {
                isState = actMove(curAction);
            } else if (curAction.type == HeroAction.Interact) {
                isState = actInteract(curAction);
            } else if (curAction.type == HeroAction.Buy) {
                isState = actBuy(curAction);
            } else if (curAction.type == HeroAction.PickUp) {
                isState = actPickUp(curAction);
            } else if (curAction.type == HeroAction.OpenChest) {
                isState = actOpenChest(curAction);
            } else if (curAction.type == HeroAction.Unlock) {
                isState = actUnlock(curAction);
            } else if (curAction.type == HeroAction.Descend) {
                isState = actDescend(curAction);
            } else if (curAction.type == HeroAction.Ascend) {
                isState = actAscend(curAction);
            } else if (curAction.type == HeroAction.Attack) {
                isState = actAttack(curAction);
            } else if (curAction.type == HeroAction.Alchemy) {
                isState = actAlchemy(curAction);
            }
            trace("英雄这次", curAction.type, "行动花费时间:", time, "秒");
            Starling.juggler.delayCall(Actor.process, time);
            return isState;
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

            doAttack(enemy);

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

    private function actAlchemy(action:HeroAction):Boolean {
        return true;
    }

    private function actAscend(action:HeroAction):Boolean {
        return true;
    }

    private function actDescend(action:HeroAction):Boolean {
        return true;

    }

    private function actUnlock(action:HeroAction):Boolean {
        return true;
    }

    private function actOpenChest(action:HeroAction):Boolean {
        return true;
    }

    /**
     * 拾取道具
     * @param action
     * @return
     */
    private function actPickUp(action:HeroAction):Boolean {
        var dst:Point = action.pos;
        var item:Item = Dungeon.level.findItem(dst);
        if (item != null) {
            if (item.doPickUp(this)) {
                trace("拾取成功");
            }
        }
        return true;
    }

    private function actBuy(action:HeroAction):Boolean {
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

    }

    override public function onCompleteAnimation():void {
        super.onCompleteAnimation();
    }

    private function actMove(action:HeroAction):Boolean {
        trace("移动");
        move(action.pos);
        return true;
    }

    /**
     * 幸运度
     * @return
     */
    public function getLuck():Number {
        return _luck;
    }

    /**
     * @inheritDoc
     * @param bundle
     */
    override public function storeInBundle(bundle:Bundle):void {

        bundle.put(STRENGTH, STR);

        bundle.put(LEVEL, lvl);
        bundle.put(EXPERIENCE, exp);

        belongings.storeInBundle(bundle);
        //
        super.storeInBundle(bundle);
    }

    /**
     * @inheritDoc
     * @param bundle
     */
    override public function restoreFromBundle(bundle:Bundle):void {
        super.restoreFromBundle(bundle);
        //
        STR = bundle.getInt(STRENGTH);
        lvl = bundle.getInt(LEVEL);
        exp = bundle.getInt(EXPERIENCE);
        //
        belongings.restoreFromBundle(bundle);
    }
}
}
