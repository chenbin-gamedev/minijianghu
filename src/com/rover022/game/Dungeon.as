package com.rover022.game {
import avmplus.INCLUDE_CONSTRUCTOR;

import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.actors.mods.npcs.Ghost;
import com.rover022.game.actors.mods.npcs.Quest;
import com.rover022.game.actors.mods.npcs.Wandmaker;
import com.rover022.game.items.Generator;
import com.rover022.game.journal.Notes;
import com.rover022.game.levels.Level;
import com.rover022.game.levels.SewerLevel;
import com.rover022.game.levels.rooms.secret.SecretRoom;
import com.rover022.game.levels.rooms.special.SpecialRoom;
import com.rover022.game.scenes.StartScene;

public class Dungeon {
    public static var level:Level;
    public static var hero:Hero;
    public static var quickslot:QuickSlot = new QuickSlot();
    public static var depth:int;
    public static var gold:int;
    public static var chapters:Array;
    public static var droppedItems:Array;
    //
    public static var version:String = "1.0.1";
    public static var seed:Number;

    public function Dungeon() {
    }

    public static function init():void {
        version = Game.versionCode;
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
//        Dungeon.level = null;
        Actor.clear();
        level.reset();
        switchLevel(level, level.entrance);

    }

    private static function switchLevel(level:Level, pos:int):void {

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
    public static function loadGame(fileName:String = "demo.json"):void {

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
}
}
