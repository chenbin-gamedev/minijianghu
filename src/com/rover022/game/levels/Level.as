package com.rover022.game.levels {
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.mods.Mod;
import com.rover022.game.items.Item;
import com.rover022.game.levels.traps.Trap;
import com.rover022.game.plants.Plant;
import com.rover022.game.utils.Pathfinder;

import starling.display.Sprite;

public class Level {
    public var width:int;
    public var height:int;
    public var length;

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
    public var mods:Array;
    public var plants:Array;
    public var traps:Array;
    public var customTiles:Array;
    public var customWalls:Array
    public static var pathfinder:Pathfinder;
    public var locked:Boolean;
    public var entrance:int;
    public var exit:int;

    public function Level() {
    }

    public function create() {

    }

    public function setSize(w:int, h:int):void {
        width = w;
        height = h;
        length = width * height;
        pathfinder = new Pathfinder();
    }

    public function reset():void {

    }

    public function creatMod():void {

    }

    public function creatMods():void {

    }

    public function creatItems():void {

    }

    public function seal() {
        if (!locked) {
            locked = true;
        }
    }

    public function unseal() {
        if (locked) {
            locked = false;
        }
    }

    public function addVisuals():Sprite {
        return null;
    }

    //todo
    public function findMod(pos:int):Mod {
        return null
    }

    public function respawner():Actor {
        return null;
    }

    public function randomRespawnCell():Actor {
        return null
    }

    public function randomDestination():Actor {
        return null
    }

    public function addItemToSpawn(item:Item):void {

    }

    public function findPrizeItem(item:Item):Item {
        return null;
    }

    public function buildFlagMap() {

    }

    public function destroy() {

    }

    public function cleanWalls() {

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

    public function fallCell(fallintoPit:Boolean):int {
        return 1;
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
    public function modPress(mod:Mod):void {

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

}
}
