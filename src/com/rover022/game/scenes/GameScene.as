package com.rover022.game.scenes {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.items.Heap;
import com.rover022.game.items.Item;
import com.rover022.game.levels.traps.Trap;
import com.rover022.game.messages.Messages;
import com.rover022.game.plants.Plant;
import com.rover022.game.ui.StatusPane;
import com.rover022.game.ui.Toast;
import com.rover022.game.ui.Toolbar;
import com.rover022.game.ui.Window;
import com.rover022.game.ui.WndHero;
import com.rover022.game.ui.WndInfoMob;
import com.rover022.game.ui.WndInfoPlant;
import com.rover022.game.ui.WndInfoTrap;
import com.rover022.game.ui.WndMessage;

import starling.display.Sprite;

/**
 * 游戏主场景
 * 1只会有一个
 * 2集合了游戏内大量经常使用到的方法
 * 3
 *
 */
public class GameScene extends PixelScene {
    public static var scene:GameScene;
    public var pane:StatusPane;

    private static var cellSelector:CellSelector;

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
    public var gases:Sprite;
    //魔法层
    public var spells:Sprite;
    //状态层
    public var statuses:Sprite;
    //表情层
    public var emoicons:Sprite;
    //血条层
    public var healthIndicators:Sprite;
    //
    public var toolbar:Toolbar;
    public var prompt:Toast = new Toast();

    public function GameScene() {
        super();
    }

    override public function create():void {
        super.create();
        trace("GameScene is create");
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
        gases = makeSprite();
        spells = makeSprite();
        statuses = makeSprite();
        emoicons = makeSprite();
        healthIndicators = makeSprite();
    }

    private function makeSprite():Sprite {
        var _s:Sprite = new Sprite();
        addChild(_s)
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

    public static function addBlob(gas:Blob):void {
        Actor.add(gas);
        if (scene != null) {
            scene.addBlobSprite(gas);
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
        Dungeon.level.mobs.add(mob);
        Actor.add(mob);
        scene.addMobSprite(mob);
    }

    public static function addMobDelay(mob:Mob, delay:Number):void {
        Dungeon.level.mobs.add(mob);
        Actor.addDelayed(mob, delay);
        scene.addMobSprite(mob);
    }

//public static function addEmoIcon(  icon:EmoIcon ):void {
//        scene.emoicons.add( icon );
//    }

//public static function addCharHealthIndicator(  indicator:CharHealthIndicator ){
//        if (scene != null) scene.healthIndicators.add(indicator);
//    }


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
    public static function pickUp(item:Item, pos:int):void {

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
//            for (Mob mob : Dungeon.level.mobs) {
//                if (mob.sprite != null)
//                    mob.sprite.visible = Dungeon.level.heroFOV[mob.pos];
//            }
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
//        Banner
//        gameOver = new Banner(BannerSprites.get(BannerSprites.Type.GAME_OVER));
//        gameOver.show(0x000000, 1
//        f
//    )
//        ;
//        scene.showBanner(gameOver);
//
//        Sample.INSTANCE.play(Assets.SND_DEATH);
    }

    /**
     * boss 被杀
     */
    public static function bossSlain():void {
//        if (Dungeon.hero.isAlive()) {
//            Banner
//            bossSlain = new Banner(BannerSprites.get(BannerSprites.Type.BOSS_SLAIN));
//            bossSlain.show(0xFFFFFF, 0.3
//            f, 5
//            f
//        )
//            ;
//            scene.showBanner(bossSlain);
//
//            Sample.INSTANCE.play(Assets.SND_BOSS);
//        }
    }

    public static function handleCell(cell:int):void {
        cellSelector.select(cell);
    }

    public static function selectCell(src:Object):void {
//        cellSelector.listener = listener;
//        if (scene != null)
//            scene.prompt(listener.prompt());
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

//        WndBag wnd =
//                mode == Mode.SEED ?
//                        WndBag.getBag( SeedPouch.class, listener, mode, title ) :
//                        mode == Mode.SCROLL ?
//                                WndBag.getBag( ScrollHolder.class, listener, mode, title ) :
//                                mode == Mode.POTION ?
//                                        WndBag.getBag( PotionBandolier.class, listener, mode, title ) :
//                                        mode == Mode.WAND ?
//                                                WndBag.getBag( WandHolster.class, listener, mode, title ) :
//                                                WndBag.lastBag( listener, mode, title );
//
//        if (scene != null) scene.addToFront( wnd );

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
//            var heap:Heap = o as Heap;
//            if (heap.type == Heap.Type.FOR_SALE && heap.size() == 1 && heap.peek().price() > 0) {
//                GameScene.show(new WndTradeItem(heap, false));
//            } else {
//                GameScene.show(new WndInfoItem(heap));
//            }
        } else if (o is Plant) {
            GameScene.show(new WndInfoPlant(o as Plant));
        } else if (o is Trap) {
            GameScene.show(new WndInfoTrap(o as Trap));
        } else {
            GameScene.show(new WndMessage(Messages.get(scene.name, "dont_know")));
        }
    }


    public function addToFront(wnd:Window):void {

    }

    public function addTrapSprite(trap:Trap):void {

    }

    public function addBlobSprite(gas:Blob):void {

    }

    public function addHeapSprite(heap:Heap):void {

    }

    public function addDiscardedSprite(heap:Heap):void {

    }

    public function addPlantSprite(plant:Plant):void {

    }

    public function addMobSprite(mob:Mob):void {

    }
}
}
