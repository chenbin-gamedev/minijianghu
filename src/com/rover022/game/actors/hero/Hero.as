package com.rover022.game.actors.hero {
import com.rover022.game.Dungeon;
import com.rover022.game.MovieClipSample;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.items.Heap;
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

    public var ready:Boolean = false;
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
            if (canAttack(ch)) {
                curAction = new HeroAction(HeroAction.Attack, cell);
                return true;
            }
        }
        item = Dungeon.level.findItem(cell);
        if (item) {
            curAction = new HeroAction(HeroAction.Pickup, cell);
            return true;
        }

        if (cell == Dungeon.level.exit && Dungeon.depth < 26) {
            curAction = new HeroAction(HeroAction.Descend, cell);
            return true;
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

        } else {
            ready = false;
        }
    }
}
}
