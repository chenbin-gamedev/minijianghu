package com.rover022.game.levels {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.actors.mobs.npcs.NPC;
import com.rover022.game.items.Item;
import com.rover022.game.levels.traps.Trap;
import com.rover022.game.plants.Plant;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.utils.Bundlable;
import com.rover022.game.utils.Bundle;
import com.rover022.game.utils.Pathfinder;

import flash.geom.Point;
import flash.utils.getDefinitionByName;

import starling.display.Sprite;

import utils.PointUtil;

public class Level implements Bundlable {
    public var width:int = 6;
    public var height:int = 6;
    public var length:int;

    public var map:Array;
    public var visited:Array;
    public var mapped:Array;
    public var discoverable:Array;

    public var passable:Array;
    public var losBlocking:Array;
    public var secret:Array;
    public var water:Array;
    public var pit:Array;
    //
    public var plants:Array;

    public var traps:Array;
    public var customTiles:Array;
    public var customWalls:Array

    public var locked:Boolean;
    public var entrance:Point;
    public var exit:Point;
    public var heaps:*;
    //怪物数据对象
    public var mobs:Array = [];
    //道具数据对象,障碍物对象
    public var blobs:Array = [];

    public static var pathfinder:Pathfinder;

    private static const VERSION:String = "version";
    private static const WIDTH:String = "width";
    private static const HEIGHT:String = "height";
    private static const MAP:String = "map";
    private static const VISITED:String = "visited";
    private static const MAPPED:String = "mapped";
    private static const ENTRANCE:String = "entrance";
    private static const EXIT:String = "exit";
    private static const LOCKED:String = "locked";
    private static const HEAPS:String = "heaps";
    private static const PLANTS:String = "plants";
    private static const TRAPS:String = "traps";
    private static const CUSTOM_TILES:String = "customTiles";
    private static const CUSTOM_WALLS:String = "customWalls";
    private static const MOBS:String = "mobs";
    private static const BLOBS:String = "blobs";
    private static const FEELING:String = "feeling";
    private var version:String = "1.0.1";

    public function Level() {
    }

    public function create():void {

    }

    public function setSize(w:int, h:int):void {
        width = w;
        height = h;
        length = width * height;
        pathfinder = new Pathfinder();
    }

    /**
     * 根据现有的数据 建立怪物 植物 和英雄
     */
    public function reset():void {
        GameScene.scene.rebuildScene();
    }

    public function creatMod():void {

    }

    public function creatMods():void {

    }

    public function creatItems():void {

    }

    public function seal():void {
        if (!locked) {
            locked = true;
        }
    }

    public function unseal():void {
        if (locked) {
            locked = false;
        }
    }

    public function addVisuals():Sprite {
        return null;
    }

    //todo
    public function findMod(pos:Point):Mob {
        for each (var mob:Mob in mobs) {
            if (PointUtil.equit(mob.pos, pos)) {
                return mob;
            }
        }

        return null
    }

    public function respawner():Actor {
        return null;
    }

    /**
     * 随机一个上面没有怪物 没有英雄 没有植物的格子
     * @return
     */
    public function randomRespawnCell():Point {
        var cell:Point;
        var a:int;
        var b:int;
        do {
            a = Math.random() * width;
            b = Math.random() * height;
            cell = new Point(a, b);

            if (cell.x == Dungeon.hero.pos.x && cell.y == Dungeon.hero.pos.x) {
                continue;
            }
            var ch:Char;
            var item:Item;
            var blob:Blob;
            blob = Dungeon.level.findBlob(cell);
            if (blob) {
                continue;
            }
            ch = Dungeon.level.findMod(cell);
            if (ch) {
                continue;
            }
            item = Dungeon.level.findItem(cell);
            if (item) {
                continue;
            }
            break;
        } while (true);
        return cell;
    }

    public function randomDestination():int {
        return null
    }

    public function addItemToSpawn(item:Item):void {

    }

    public function findPrizeItem(item:Item):Item {
        return null;
    }

    public function buildFlagMap():void {

    }

    public function destroy():void {

    }

    public function cleanWalls():void {

    }

    public static function set(_cell:int, _terrain:int, level:Level):void {

    }

    public function plant(plant:Plant, pos:int):Plant {
        return null;
    }

    public function uproot(pos:int):void {

    }

    /**
     * 掉落道具  填充数据  通知场景放置道具
     * @param item
     * @param cell
     * @return
     */
    public function drop(item:Item, cell:Point):Item {
        item.pos = cell;
        this.blobs.push(item);
        GameScene.scene.addItemSprite(item);
        return item;
    }

    public function setTrap(trap:Trap, pos:int):void {

    }

    public function disarmTrap(pos:int):void {

    }

    public function discover(cell:int):void {

    }

    public function fallCell(fallintoPit:Boolean):Point {
        return new Point();
    }

    /**
     * 英雄点击
     * @param cell
     * @param ch
     */
    public function press(cell:int, ch:Char):void {

    }

    /**
     * 怪物点击
     * @param mod
     */
    public function modPress(mod:Mob):void {

    }

    public function updateFieldOfView():void {

    }

    public function distance(a:int, b:int):void {

    }

    public function distNoDiag(a:int, b:int):int {
        return 0;
    }

    public function insideMap(tile:int):Boolean {
        return true;
    }

    public function tileName(tile:int):String {
        switch (tile) {
            case Terrain.CHASM:
                break;
        }
        return "";
    }

    public function tileDesc(tile:int):String {
        switch (tile) {
            case Terrain.CHASM:
                break;
        }
        return "";
    }

    private static function pointToCell(brokenPos:Point):Point {
        return brokenPos;
    }

    public function findBlob(cell:Point):Blob {

        return null
    }

    public function findItem(cell:Point):Item {
        for each (var item:Item in blobs) {
            if (PointUtil.equit(cell, item.pos)) {
                return item;
            }
        }
        return null;
    }

    /**
     * 能否通过这一点
     * 判断条件
     * 1 不能是入口
     * 2 不能是出口
     * 3 不能有道具
     * 4 不能有敌人
     * 5 不能有障碍物
     * @param Point
     * @return
     */
    public function canPassable(_pos:Point):Boolean {
        if (PointUtil.equit(exit, _pos)) {
            return false;
        }
        if (PointUtil.equit(entrance, _pos)) {
            return false;
        }
        var item:Item = findItem(_pos);
        if (item) {
            return false;
        }
        var mob:Mob = findMod(_pos);
        if (mob) {
            return false;
        }
        var blob:Blob = findBlob(_pos);
        if (blob) {
            return false;
        }
        return true
    }

    /**
     * @inheritDoc
     * @param bundle
     */
    public function restoreFromBundle(bundle:Bundle):void {
        version = bundle.getString(VERSION);
        width = bundle.getInt(WIDTH);
        height = bundle.getInt(HEIGHT);
        map = bundle.getArray(MAP);
        mobs = bundle.getBundlableList(MOBS);
        blobs = bundle.getBundlableList(BLOBS);
    }

    /**
     * @inheritDoc
     * @param bundle
     */
    public function storeInBundle(bundle:Bundle):void {
        bundle.put(VERSION, version);
        bundle.put(WIDTH, width);
        bundle.put(HEIGHT, height);
        bundle.put(MAP, map);
        bundle.putBundleList(MOBS, mobs);//里面包含怪物 英雄
        bundle.putBundleList(BLOBS, blobs);//里面包含障碍物 掉落道具 入口和出口
        //可扩展数据
        bundle.putBundleList(PLANTS, plants);
        bundle.putBundleList(TRAPS, traps);
    }
}
}
