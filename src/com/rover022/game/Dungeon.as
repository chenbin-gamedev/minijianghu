package com.rover022.game {
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.actors.hero.HeroClass;
import com.rover022.game.actors.mobs.npcs.Ghost;
import com.rover022.game.actors.mobs.npcs.Wandmaker;
import com.rover022.game.items.Generator;
import com.rover022.game.journal.Notes;
import com.rover022.game.levels.Level;
import com.rover022.game.levels.SewerLevel;
import com.rover022.game.levels.rooms.secret.SecretRoom;
import com.rover022.game.levels.rooms.special.SpecialRoom;
import com.rover022.game.utils.Bundle;

import flash.geom.Point;

public class Dungeon {
    public static var isdebug:Boolean = true;
    public static var level:Level;
    public static var hero:Hero;
    public static var quickslot:QuickSlot = new QuickSlot();
    public static var depth:int;
    public static var gold:int;
    public static var chapters:Array;
    public static var droppedItems:Array = [];
    //
    public static var version:String = "1.0.1";
    public static var seed:Number;

    public function Dungeon() {
    }

    public static function init():void {
        version = MiniGame.version;
        seed = Dungeon.randomSeed();
        Actor.clear();
        Actor.resetNextID();
        //
        seed = Math.random();
        SpecialRoom.initForRun();
        SecretRoom.initForRun();
        //
        Statistics.reset();
        Notes.reset();
        quickslot.reset();
        depth = 0;
        gold = 0;
        droppedItems = new Array();
        //任务系统
        Ghost.quest.reset();
        Wandmaker.quest.reset();
        //
        Generator.reset();
        Generator.initArtifacts();
        hero = new Hero();
        hero.live();
        //
        Badges.reset();
//        StartScene.curClass.initHero(hero);
    }

    public static function isChallenged():Boolean {
        return true;
    }

    public static function newLevel():Level {
        Dungeon.level = null;
        Actor.clear();
        depth++;
        var level:Level;
        switch (depth) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                level = new SewerLevel();
                break;
        }
        level.create();
        return level;
    }

    public static function resetLevel():void {
        Actor.clear();
        level.reset();
        switchLevel(level, level.entrance);
    }

    /**
     * 进入关卡等级
     * @param level
     * @param pos 英雄出生点
     */
    public static function switchLevel(level:Level, pos:Point):void {
        if (pos == null) {
            pos = new Point();
        }
        Dungeon.level = level;
        hero.pos = pos;
        hero.curAction = hero.lastAction = null;
        observe();
        saveAll();
    }

    public static function observe():void {

    }

    public static function saveGame(fileName:String = "demo.txt"):void {

    }

    public static function saveLevel():void {

    }

    public static function saveAll():void {
        if (hero != null && hero.isAlive()) {
            Actor.fixTime();
            saveGame();
            saveLevel();
        }
    }

    /**
     * 加载游戏
     * @param fileName
     */
    public static function loadGame(cl:HeroClass, fullLoad:Boolean = true):void {
        //loadGame(gameFile(cl), true);
        var bundle:Bundle = gameBundle();
        quickslot.reset();
        level = null;
        depth = bundle.depth;
        gold = bundle.gold;
        hero = bundle.getHero();
        droppedItems = bundle.getDroppedItems();
        //
        if (fullLoad) {
            SpecialRoom.restoreRoomsFromBundle();
            SecretRoom.restoreRoomsFromBundle();
        }
        Notes.restoreRoomsFromBundle();

    }

    private static function gameBundle():Bundle {
        return new Bundle();
    }

    public static function gameFile(cl:HeroClass):String {
        switch (cl.type) {
            case HeroClass.WARRIOR:
                return "";
            case HeroClass.HUNTRESS:
                return "";
            case HeroClass.MAGE:
                return "";
            case HeroClass.ROGUE:
                return "";
        }
        return "";
    }

    public static function deleteGame():void {

    }

    public static function fail():void {

    }

    public static function win():void {

    }

    public static var passable:Array;

    public static function findPath(ch:Char, from:int, to:int, map:Array, visibles:Array):Array {
        return [];
    }

    public static function findStep(ch:Char, from:int, to:int, map:Array, visibles:Array):int {
        return 1;
    }

    public static function flee(ch:Char, from:int, to:int, map:Array, visibles:Array):int {
        return 1;
    }

    private static function randomSeed():Number {
        return Math.random()
    }

    public static function loadLevel(curClass:HeroClass):Level {
        Dungeon.level = null;
        Actor.clear();
        var bundle:Bundle = Bundle.readFromFile();
        var level:Level = bundle.getLevel();
        return level;
    }

    public static function seedCurDepth():* {

    }
}
}
