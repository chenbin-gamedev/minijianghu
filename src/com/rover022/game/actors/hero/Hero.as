package com.rover022.game.actors.hero {
import com.rover022.game.actors.Char;
import com.rover022.game.items.weapon.missiles.MissileWeapon;

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


    public function Hero() {
        super();
        attackSkill = 10;
        defenseSkill = 5;

        belongings = new Belongings(this);
        visibleEnemies = [];
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
}
}
