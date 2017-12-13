package com.rover022.game {
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.CharClass;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.actors.mobs.npcs.Ghost;
import com.rover022.game.actors.mobs.npcs.Wandmaker;
import com.rover022.game.items.Generator;
import com.rover022.game.journal.Notes;
import com.rover022.game.levels.HallsLevel;
import com.rover022.game.levels.Level;
import com.rover022.game.levels.SewerLevel;
import com.rover022.game.levels.rooms.secret.SecretRoom;
import com.rover022.game.levels.rooms.special.SpecialRoom;
import com.rover022.game.scenes.GameScene;
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
    private static const QUICKSLOT:String = "quickslot";

    public function Dungeon() {

    }

    /**
     * 地下城初始化
     */
    public static function init():void {
        version = MiniGame.version;
        level = new HallsLevel();
        hero = new Hero();
        //
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
        droppedItems = [];
        //任务系统
        Ghost.quest.reset();
        Wandmaker.quest.reset();
        //
        Generator.reset();
        Generator.initArtifacts();
        //
    }

    public static function isChallenged():Boolean {
        return true;
    }

    /**
     * 进入下一层地下城
     * @return
     */
    public static function newLevel():Level {
        Dungeon.level = null;
        Actor.clear();
        depth++;
        var level:Level;
        switch (depth) {
            case 0:
                //level = new HallsLevel();
                //break;
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
        Dungeon.level = level;
        Dungeon.hero.ready = true;
        GameScene.scene.rebuildScene();
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
        Dungeon.level = level;
        Dungeon.level.reset();
        if (pos == null) {
            pos = new Point();
        }
        Actor.init();
        hero.pos = pos;
        hero.ready = true;
        hero.curAction = hero.lastAction = null;
        observe();
    }

    public static function observe():void {

    }

    public static function saveAll():void {
        if (hero != null && hero.isAlive()) {
            Actor.fixTime();
            saveGame();
            saveLevel();
        }
    }

    /**
     * 保存游戏文件
     * @param fileName
     */
    public static function saveGame(fileName:String = WR_GAME_FILE):void {
        var bundle:Bundle = new Bundle();
        version = MiniGame.version;
        bundle.put(VERSION, version);
        bundle.put(GOLD, gold);
        bundle.put(DEPTH, depth);
        bundle.putBundlable(LEVEL, level);
        bundle.putBundlable(HERO, hero);
        bundle.put(QUICKSLOT, quickslot);
        Bundle.write(bundle, fileName);
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
        var bundle:Bundle = Bundle.read(fileName);
        quickslot.reset();
        if (bundle) {
            depth = bundle.getInt(DEPTH);
            gold = bundle.getInt(GOLD);
            hero = bundle.getBundlable(HERO) as Hero;
            level = bundle.getBundlable(LEVEL) as Level;
            droppedItems = bundle.getBundlableList(DROPPED);
            //
            if (fullLoad) {
                SpecialRoom.restoreRoomsFromBundle();
                SecretRoom.restoreRoomsFromBundle();
            }
            Notes.restoreRoomsFromBundle();
        } else {
            //如果加载失败 或是加载的文件不纯在 启动新存档逻辑
            Dungeon.init();
        }
    }

    public static function deleteGame(fileName:String = WR_GAME_FILE):void {
        Bundle.deleteGame(fileName);
    }

    /**
     *  保存关卡 RG_DEPTH_FILE,MG_DEPTH_FILE,RN_DEPTH_FILE,WR_DEPTH_FILE
     * @param fileName
     * @return
     */
    public static function saveLevel(fileName:String = WR_DEPTH_FILE):void {
        var bundle:Bundle = new Bundle();
        level.storeInBundle(bundle);
        Bundle.write(bundle, fileName);
    }

    /**
     * 加载关卡 RG_DEPTH_FILE,MG_DEPTH_FILE,RN_DEPTH_FILE,WR_DEPTH_FILE
     * @param fileName
     * @return
     */
    public static function loadLevel(fileName:String = WR_DEPTH_FILE):Level {
        Dungeon.level = null;
        Actor.clear();
        var bundle:Bundle = Bundle.read(fileName);
        var level:Level = new Level();
        level.restoreFromBundle(bundle);
        return level;
    }

    /**
     * 读取文件存档 一共四个档位
     * @param cl
     * @return
     */
    public static function gameFile(cl:CharClass):String {
        switch (cl.type) {
            case CharClass.WARRIOR:
                return WR_GAME_FILE;
            case CharClass.HUNTRESS:
                return RN_GAME_FILE;
            case CharClass.MAGE:
                return MG_GAME_FILE;
            case CharClass.ROGUE:
                return RG_GAME_FILE;
        }
        return "";
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

    public static function getFristMob():Mob {
        for each (var mob:Mob in level.mobs) {
            if (mob.alignment == Char.ENEMY) {
                return mob;
            }
        }
        return null;
    }
}
}
