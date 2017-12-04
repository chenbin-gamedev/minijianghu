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
import com.rover022.game.utils.Pathfinder;

import flash.geom.Point;

import starling.display.Sprite;

import utils.PointUtil;

public class Level {
    public var width:int;
    public var height:int;
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
    public var blobs:Array = [];
    public var traps:Array;
    public var customTiles:Array;
    public var customWalls:Array

    public var locked:Boolean;
    public var entrance:Point;
    public var exit:Point;
    public var heaps:*;
    public var mobs:Array = [];

    public static var pathfinder:Pathfinder;

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
     * 测试用的数据
     * @return
     */
    public static function makeNewLevel():Level {
        var level:Level = new Level();
        level.setSize(6, 6);
        level.map = [
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0]];
        pathfinder = new Pathfinder();
        pathfinder.loadMap(level.map, 6, 6);
        //
        level.mobs = [];
        makeMob(new Point(5, 5));
//        makeMob(new Point(4, 5));

        //加入一个NPC
        var npc:NPC = new NPC();
        npc.pos = Level.pointToCell(new Point(3, 5));
        level.mobs.push(npc);

        //
        function makeMob(brokenPos:Point):void {
            var mob:Mob = new Mob();
            mob.spawn(Dungeon.depth);
            mob.pos = Level.pointToCell(brokenPos);
            level.mobs.push(mob);
        }

        return level;
    }

    public function reset():void {

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
    public function randomRespawnCell():int {
        return 0;
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

    public function drop(item:Item, cell:int):Item {
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
        for each (var item:Item in Dungeon.droppedItems) {
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
}
}
