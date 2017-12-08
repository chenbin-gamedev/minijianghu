package com.rover022.game.scenes {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.items.Heap;
import com.rover022.game.items.Item;
import com.rover022.game.items.potions.Honeypot;
import com.rover022.game.items.potions.Potion;
import com.rover022.game.levels.Level;
import com.rover022.game.levels.traps.Trap;
import com.rover022.game.messages.Messages;
import com.rover022.game.plants.Plant;
import com.rover022.game.tiles.DungenTerrainTilemap;
import com.rover022.game.tiles.DungeonTilemap;
import com.rover022.game.ui.GameLog;
import com.rover022.game.ui.StatusPane;
import com.rover022.game.ui.Toast;
import com.rover022.game.ui.Toolbar;
import com.rover022.game.ui.Window;
import com.rover022.game.windows.WndHero;
import com.rover022.game.windows.WndInfoMob;
import com.rover022.game.windows.WndInfoPlant;
import com.rover022.game.windows.WndInfoTrap;
import com.rover022.game.windows.WndMessage;

import flash.geom.Point;

import starling.display.Sprite;

/**
 * 游戏主场景
 * 1只会有一个
 * 2集合了游戏内大量经常使用到的方法
 *
 *
 *
 *
 */
public class GameScene extends PixelScene {
    public static var scene:GameScene;
    public var pane:StatusPane;

    public static var cellSelector:CellSelector;

    //地面层
    public var terrain:Sprite;
    //土壤层
    public var customTiles:Sprite;
    //视觉效果层
    public var levelVisuals:Sprite;
    //墙面层
    public var customWalls:Sprite;
    //波纹层
    public var ripples:Sprite;
    //植物层
    public var plants:Sprite;
    //陷阱层
    public var traps:Sprite;
    //堆层
    public var heaps:Sprite;
    //怪物层
    public var mobs:Sprite;
    //粒子层
    public var emitters:Sprite;
    //特效层
    public var effects:Sprite;
    //气体层
    public var blobs:Sprite;
    //魔法层
    public var spells:Sprite;
    //状态层
    public var statuses:Sprite;
    //表情层
    public var emoicons:Sprite;
    //血条层
    public var healthIndicators:Sprite;
    //
    public var toolbar:Toolbar = new Toolbar();
    public var prompt:Toast = new Toast();
    public var hero:Hero;
    public var tiles:DungenTerrainTilemap;
    public var log:GameLog;
    public var defaultCellListener:Function;

    //
    public var interlevelScene:InterlevelScene = new InterlevelScene();

    public function GameScene() {
        super();
        trace("GameScene init");
    }

    override public function create():void {
        super.create();
        trace("GameScene is create");
        cellSelector = new CellSelector();
        cellSelector.x = 6;
        cellSelector.y = 62 + 77;
        addChild(cellSelector);
        terrain = makeSprite();
        customTiles = makeSprite();
        levelVisuals = makeSprite();
        customWalls = makeSprite();
        ripples = makeSprite();
        plants = makeSprite();
        traps = makeSprite();
        heaps = makeSprite();
        mobs = makeSprite();
        emitters = makeSprite();
        effects = makeSprite();
        blobs = makeSprite();
        spells = makeSprite();
        statuses = makeSprite();
        emoicons = makeSprite();
        healthIndicators = makeSprite();
        scene = this;
        //关卡设计面板初始化一次
        interlevelScene.enterDungeon();
        //装配地面
        //DungeonTilemap.setupVariance(Dungeon.level.map.length, Dungeon.seedCurDepth());
        tiles = new DungenTerrainTilemap();
        tiles.map(null, 6);
        terrain.addChild(tiles);
        //
        log = new GameLog();
        addChild(log);
        //
        Dungeon.hero.next();
        //Camera
        fadeIn();
        //初始化点击事件
        selectCall(defaultCellListener);
        //添加toolbar
        toolbar.y = 540;
        addChild(toolbar);
    }

    private function makeSprite():Sprite {
        var _s:Sprite = new Sprite();
        cellSelector.addChild(_s);
        return _s;
    }

    public static function addPlant(plant:Plant):void {
        if (scene != null) {
            scene.addPlantSprite(plant);
        }
    }

    public static function addTrap(trap:Trap):void {
        if (scene != null) {
            scene.addTrapSprite(trap);
        }
    }

    public static function addBlob(blob:Blob):void {
        Actor.add(blob);
        if (scene != null) {
            scene.addBlobSprite(blob);
        }
    }

    public static function addHeap(heap:Heap):void {
        if (scene != null) {
            scene.addHeapSprite(heap);
        }
    }

    public static function discardHeap(heap:Heap):void {
        if (scene != null) {
            scene.addDiscardedSprite(heap);
        }
    }

    public static function addMob(mob:Mob):void {
        Dungeon.level.mobs.push(mob);
        Actor.add(mob);
        trace(Dungeon.level.map);

        Dungeon.level.map[mob.pos.x][mob.pos.y] = 1;
        scene.addMobSprite(mob);
    }

    public static function addMobDelay(mob:Mob, delay:Number):void {
        Dungeon.level.mobs.add(mob);
        Actor.addDelayed(mob, delay);
        scene.addMobSprite(mob);
    }

    /**
     * 选择了单元格
     * @param onListen
     */
    public static function selectCall(onListen:Function):void {

    }

    /**
     * 捡起道具
     * @param item
     * @param pos
     */
    public static function pickUp(item:Item, pos:Point):void {
        if (scene != null) {
            scene.toolbar.pickup(item, pos);
        }
    }

    /**
     * 游戏状态面板更新
     * 游戏状态面板只会有一个
     */
    public static function updataKeyDisplay():void {
        if (scene != null) {
            scene.pane.updateKeys();
        }
    }

    /**
     * 更新地图
     */
    public static function updateMap():void {
        if (scene != null) {
            updateFog();
        }
    }

    /**
     * 更新某一格内的地图
     */
    public static function updateMapCell(cell:int):void {
        if (scene != null) {
            updateFogCell(cell);
        }
    }

    public static function plantSeed(cell:int):void {
        if (scene != null) {
            //scene.terrainFeatures.growPlant(cell);
        }
    }

    public static function discoverTile(pos:int, oldValue:int):void {
        if (scene != null) {

        }
    }

    /**
     * 显示游戏内部窗口
     * @param wnd
     */
    public static function show(wnd:Window):void {
        if (scene != null) {
            cancelCellSelector();
            scene.addToFront(wnd);
        }
    }

    /**
     * 更新烟雾
     */
    public static function updateFog():void {
        if (scene != null) {

        }
    }

    /**
     * 更新烟雾格
     * @param x
     * @param y
     * @param w
     * @param h
     */
    public static function updateFogRect(x:int, y:int, w:int, h:int):void {
        if (scene != null) {

        }
    }

    /**
     * 更新烟雾格
     * @param cell
     */
    public static function updateFogCell(cell:int):void {
        if (scene != null) {

        }
    }

    public static function afterObserve():void {
        if (scene != null) {

        }
    }

    /**
     * 闪光
     * @param color
     */
    public static function flash(color:int):void {
        scene.fadeIn(0xFF000000 | color, true);
    }

    /**
     * 游戏结束
     */
    public static function gameOver():void {

    }

    /**
     * boss 被杀
     */
    public static function bossSlain():void {

    }

    public static function handleCell(cell:Point):void {
        cellSelector.select(cell);
    }

    public static function selectCell(src:Object):void {

    }

    private static function cancelCellSelector():Boolean {
        cellSelector.resetKeyHold();
        if (cellSelector.listener != null && cellSelector.listener != null) {
            cellSelector.cancel();
            return true;
        } else {
            return false;
        }
    }

    public static function selectItem(item:Item):Item {
        cancelCellSelector();
        return item;
    }

    public static function cancel():Boolean {
        if (Dungeon.hero != null && (Dungeon.hero.curAction != null || Dungeon.hero.resting)) {

            Dungeon.hero.curAction = null;
            Dungeon.hero.resting = false;
            return true;

        } else {

            return cancelCellSelector();

        }
    }

    public static function ready():void {
        //selectCell( defaultCellListener );
        //QuickSlotButton.cancel();
        if (scene != null && scene.toolbar != null) scene.toolbar.examining = false;
    }

    public static function checkKeyHold():void {
        cellSelector.processKeyHold();
    }

    /**
     * 检查单元格
     * @param cell
     */
    public static function examineCell(cell:int):void {

    }

    /**
     * 检查对象
     * @param o
     */
    public static function examineObject(o:Object):void {
        if (o == Dungeon.hero) {
            GameScene.show(new WndHero());
        } else if (o is Mob) {
            GameScene.show(new WndInfoMob(o as Mob))
        } else if (o is Heap) {

        } else if (o is Plant) {
            GameScene.show(new WndInfoPlant(o as Plant));
        } else if (o is Trap) {
            GameScene.show(new WndInfoTrap(o as Trap));
        } else {
            GameScene.show(new WndMessage(Messages.get(scene.name, "dont_know")));
        }
    }

    public function addToFront(wnd:Window):void {
        addChild(wnd);
    }

    public function addTrapSprite(trap:Trap):void {

    }

    public function addHeapSprite(heap:Heap):void {

    }

    public function addDiscardedSprite(heap:Heap):void {

    }

    public function addBlobSprite(gas:Blob):void {
        blobs.addChild(gas);
    }

    public function addPlantSprite(plant:Plant):void {
        plants.addChild(plant)
    }

    public function addMobSprite(mob:Char):void {
        mobs.addChild(mob);
        mob.reset();
    }

    public function addItemSprite(item:Item):void {
        blobs.addChild(item);
        item.reset();
    }

    public function removeAllSprite():void {
        mobs.removeChildren();
        blobs.removeChildren();
        heaps.removeChildren();
        plants.removeChildren();
    }

    public function rebuildScene():void {
        removeAllSprite();
        for each (var mob:Mob in Dungeon.level.mobs) {
            addMobSprite(mob);
        }
        //
        for each (var item:Item in Dungeon.droppedItems) {
            addItemSprite(item);
        }
        //
        for each (var blob:Blob in Dungeon.level.blobs) {
            addBlobSprite(blob);
        }
        addMobSprite(Dungeon.hero);
    }

}
}
