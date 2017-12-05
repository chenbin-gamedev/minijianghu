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

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.geom.Point;
import flash.utils.ByteArray;

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
    //
    public static var DefaultHero:Class = Hero;

    private static const RG_GAME_FILE:String = "game.dat";
    private static const RG_DEPTH_FILE:String = "depth%d.dat";

    private static const WR_GAME_FILE:String = "warrior.dat";
    private static const WR_DEPTH_FILE:String = "warrior%d.dat";

    private static const MG_GAME_FILE:String = "mage.dat";
    private static const MG_DEPTH_FILE:String = "mage%d.dat";

    private static const RN_GAME_FILE:String = "ranger.dat";
    private static const RN_DEPTH_FILE:String = "ranger%d.dat";

    private static const VERSION:String = "version";
    private static const SEED:String = "seed";
    private static const CHALLENGES:String = "challenges";
    private static const HERO:String = "hero";
    private static const GOLD:String = "gold";
    private static const DEPTH:String = "depth";
    private static const DROPPED:String = "dropped%d";
    private static const LEVEL:String = "level";
    private static const LIMDROPS:String = "limited_drops";
    private static const CHAPTERS:String = "chapters";
    private static const QUESTS:String = "quests";
    private static const BADGES:String = "badges";

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
        hero = new DefaultHero();
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
            default:
                level = new Level();
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

    public static function saveGame(fileName:String = WR_GAME_FILE):void {
        var bundle:Bundle = new Bundle();
        version=MiniGame.version;
        bundle.put(VERSION,version);
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
     *  四个档位
     *  RG_GAME_FILE
     *  WR_GAME_FILE
     *  MG_GAME_FILE
     *  RN_GAME_FILE
     * @param fileName
     */
    public static function loadGame(fileName:String = WR_GAME_FILE, fullLoad:Boolean = true):void {
        var bundle:Bundle = gameBundle(fileName);
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

    /**
     * 加载关卡
     *  四个文件
     *  RG_DEPTH_FILE
     *  MG_DEPTH_FILE
     *  RN_DEPTH_FILE
     *  WR_DEPTH_FILE
     * @param curClass
     * @return
     */
    public static function loadLevel(fileName:String = WR_DEPTH_FILE):Level {
        Dungeon.level = null;
        Actor.clear();
        var bundle:Bundle = gameBundle(fileName);
        var level:Level = bundle.get(LEVEL) as Level;
        return level;
    }

    private static function gameBundle(fileName:String):Bundle {
        var file:File = File.applicationDirectory.resolvePath(fileName);
        var stream:FileStream = new FileStream();
        var bytes:ByteArray = new ByteArray();
        stream.open(file, FileMode.READ);
        stream.readBytes(bytes, 0, stream.bytesAvailable);
        stream.close();
        return Bundle.read(bytes);
    }

    /**
     * 读取文件存档 一共四个档位
     * @param cl
     * @return
     */
    public static function gameFile(cl:HeroClass):String {
        switch (cl.type) {
            case HeroClass.WARRIOR:
                return WR_GAME_FILE;
            case HeroClass.HUNTRESS:
                return RN_GAME_FILE;
            case HeroClass.MAGE:
                return MG_GAME_FILE;
            case HeroClass.ROGUE:
                return RG_GAME_FILE;
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

    public static function seedCurDepth():* {

    }
}
}
