package com.rover022.game.actors.hero {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.MovieClipSample;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.mobs.npcs.NPC;
import com.rover022.game.items.Item;
import com.rover022.game.items.weapon.missiles.MissileWeapon;
import com.rover022.game.messages.Messages;
import com.rover022.game.sprites.CharSprite;

import flash.geom.Point;

public class Hero extends Char {
    public static const MAX_LEVEL:int = 99;
    public static const ATTACK:String = "attackSkill";
    public static const DEDENSE:String = "defenseSkill";
    public static const STRENGTH:String = "STR";
    public static const LEVEL:String = "leve";
    public static const EXPERIENCE:String = "exp";
    public static const HTBOOST:String = "htboost";

    public var ready:Boolean = true;
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

    public function updateHT(boostHP:Boolean):void {

    }

    public function shoot(enemy:Char, wep:MissileWeapon):Boolean {
        return true
    }

    public function canAttack(enemy:Char):Boolean {
        return true;
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

    private function actAlchemy(curAction:HeroAction):Boolean {
        return true;
    }

    private function actAttack(action:HeroAction):Boolean {
        enemy = action.target;
        if (enemy.isAlive() && canAttack(enemy) && !isCharmedBy(enemy)) {
            //Invisibility.dispel();
            //spend(attackDelay());
            //sprite.attack(enemy.pos);
            attack(enemy);
            ready = true;
            return false;
        } else {
            trace("enemy isAlive ", enemy.isAlive());
            trace("canAttack ", canAttack(enemy));
            trace("isCharmedBy()", !isCharmedBy(enemy));
            trace("不能执行攻击动作");
        }
        return true;
    }

    private function isCharmedBy(enemy:Char):Boolean {
        return false;
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
//        if (getCloser(action.pos)) {
//            return true;
//        } else {
////            ready();
//            return false;
//        }
//        return true;
    }

    private function getCloser(target:Point):Boolean {

        if (target == pos) {
            move(pos);
            return true;
        }
        return false;

//        if (rooted) {
//            Camera.main.shake( 1, 1f );
//            return false;
//        }
//
//        int step = -1;
//
//        if (Dungeon.level.adjacent( pos, target )) {
//
//            path = null;
//
//            if (Actor.findChar( target ) == null) {
//                if (Dungeon.level.pit[target] && !flying && !Dungeon.level.solid[target]) {
//                    if (!Chasm.jumpConfirmed){
//                        Chasm.heroJump(this);
//                        interrupt();
//                    } else {
//                        Chasm.heroFall(target);
//                    }
//                    return false;
//                }
//                if (Dungeon.level.passable[target] || Dungeon.level.avoid[target]) {
//                    step = target;
//                }
//            }
//
//        } else {
//
//            boolean newPath = false;
//            if (path == null || path.isEmpty() || !Dungeon.level.adjacent(pos, path.getFirst()))
//                newPath = true;
//            else if (path.getLast() != target)
//                newPath = true;
//            else {
//                //looks ahead for path validity, up to length-1 or 2.
//                //Note that this is shorter than for mobs, so that mobs usually yield to the hero
//                int lookAhead = (int) GameMath.gate(0, path.size()-1, 2);
//                for (int i = 0; i < lookAhead; i++){
//                    int cell = path.get(i);
//                    if (!Dungeon.level.passable[cell] || (fieldOfView[cell] && Actor.findChar(cell) != null)) {
//                        newPath = true;
//                        break;
//                    }
//                }
//            }
//
//            if (newPath) {
//
//                int len = Dungeon.level.length();
//                boolean[] p = Dungeon.level.passable;
//                boolean[] v = Dungeon.level.visited;
//                boolean[] m = Dungeon.level.mapped;
//                boolean[] passable = new boolean[len];
//                for (int i = 0; i < len; i++) {
//                    passable[i] = p[i] && (v[i] || m[i]);
//                }
//
//                path = Dungeon.findPath(this, pos, target, passable, fieldOfView);
//            }
//
//            if (path == null) return false;
//            step = path.removeFirst();
//
//        }
//
//        if (step != -1) {
//
//            int moveTime = 1;
//            if (belongings.armor != null && belongings.armor.hasGlyph(Stone.class) &&
//                    (Dungeon.level.map[pos] == Terrain.DOOR
//                            || Dungeon.level.map[pos] == Terrain.OPEN_DOOR
//                            || Dungeon.level.map[step] == Terrain.DOOR
//                            || Dungeon.level.map[step] == Terrain.OPEN_DOOR )){
//                moveTime *= 2;
//            }
//            sprite.move(pos, step);
//            move(step);
//
//            spend( moveTime / speed() );
//
//            search(false);
//
//            if (subClass == HeroSubClass.FREERUNNER){
//                Buff.affect(this, Momentum.class).gainStack();
//            }
//
//            //FIXME this is a fairly sloppy fix for a crash involving pitfall traps.
//            //really there should be a way for traps to specify whether action should continue or
//            //not when they are pressed.
//            return InterlevelScene.mode != InterlevelScene.Mode.FALL;
//
//        } else {
//
//            return false;
//
//        }

    }

}
}
