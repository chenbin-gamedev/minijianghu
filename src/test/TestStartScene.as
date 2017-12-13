package test {
import com.bit101.components.Window;
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.scenes.InterlevelScene;
import com.rover022.game.scenes.StartScene;
import com.rover022.game.utils.DebugTool;

import starling.display.Button;

import starling.events.Event;

import utils.MenuButton;

public class TestStartScene extends StartScene {
    private var simBtn:Button;

    public function TestStartScene() {
        super();
    }

    override public function create():void {
        super.create();
        var btn:MenuButton;

        btn = new MenuButton("加载");

        addChild(btn);
        btn.addEventListener(Event.TRIGGERED, onStartClick);

        btn = new MenuButton("新游戏");
        btn.y = 30;
        addChild(btn);
        btn.addEventListener(Event.TRIGGERED, onNewClick);

        btn = new MenuButton("删除");
        btn.y = 60;
        addChild(btn);
        btn.addEventListener(Event.TRIGGERED, onDelClick);
        //
        simBtn = DebugTool.makeButton("load_2");
        simBtn.addEventListener(Event.TRIGGERED, onLoadGameOn2Click);
        simBtn.x = 80;
        addChild(simBtn);
        //


    }

    private function onLoadGameOn2Click(event:Event):void {
        Dungeon.loadGame(WndTest.minisave);
        //进入游戏场景
        MiniGame.switchScene(GameScene);
        MiniGame.scene.addChild(new WndTest());
    }

    private function onDelClick(event:Event):void {
        Dungeon.deleteGame();
    }

    private function onNewClick(event:Event):void {
        Dungeon.init();
        //进入游戏场景
        MiniGame.switchScene(GameScene);
        MiniGame.scene.addChild(new WndTest());
    }

    public static function initTestFunButton(_x:Number, _y:Number, _txt:String, onLoadClick:Function):MenuButton {
        var btn:MenuButton = new MenuButton(_txt);
        btn.x = _x;
        btn.y = _y;
        btn.addEventListener(Event.TRIGGERED, onLoadClick);
        return btn;
    }

    private function onStartClick(event:Event):void {
//        startNewGame();
        Dungeon.loadGame();
        //进入游戏场景
        MiniGame.switchScene(GameScene);
        MiniGame.scene.addChild(new WndTest());
    }

    override public function startNewGame():void {
        //
        InterlevelScene.mode = InterlevelScene.DESCEND;
        //加载游戏数据
        Dungeon.loadGame();
        //进入游戏场景
        MiniGame.switchScene(GameScene);
        MiniGame.scene.addChild(new WndTest());
    }
}
}

import com.rover022.game.Dungeon;
import com.rover022.game.levels.Level;
import com.rover022.game.ui.Window;
import com.rover022.game.utils.DebugTool;

import starling.display.Button;
import starling.events.Event;

/**
 * 游戏内页 弹出的小窗口 用来测试一系列功能
 */
class WndTest extends Window {
    public static const minisave:String = "test2.dat";

    public function WndTest() {
        var simBtn:Button;

        simBtn = DebugTool.makeButton("加载游戏");
        simBtn.addEventListener(Event.TRIGGERED, onLoadClick);
        addChild(simBtn);

        simBtn = DebugTool.makeButton("保存游戏");
        simBtn.y = 20;
        simBtn.addEventListener(Event.TRIGGERED, onSaveClick);
        addChild(simBtn);

        simBtn = DebugTool.makeButton("load_2");
        simBtn.addEventListener(Event.TRIGGERED, onLoadGameOn2Click);
        simBtn.x = 80;
        addChild(simBtn);

        simBtn = DebugTool.makeButton("save_2");
        simBtn.x = 80;
        simBtn.y = 20;
        simBtn.addEventListener(Event.TRIGGERED, onSaveGameOn2Click);
        addChild(simBtn);

        simBtn = DebugTool.makeButton("加载关卡");
        simBtn.x = 0;
        simBtn.y = 50;
        simBtn.addEventListener(Event.TRIGGERED, onLoadLevelClick);
        addChild(simBtn);

        simBtn = DebugTool.makeButton("保存关卡");
        simBtn.x = 80;
        simBtn.y = 50;
        simBtn.addEventListener(Event.TRIGGERED, onSaveLevelClick);
        addChild(simBtn);

    }

    private function onLoadGameOn2Click(event:Event):void {
        Dungeon.loadGame(WndTest.minisave);
    }

    private function onSaveGameOn2Click(event:Event):void {
        Dungeon.saveGame(WndTest.minisave);
        trace("保存文件到test2.dat");
    }

    private function onSaveLevelClick(e:Event):void {
        Dungeon.saveLevel();
    }

    private function onLoadLevelClick(e:Event):void {
        var level:Level = Dungeon.loadLevel();
        Dungeon.switchLevel(level, level.entrance);
    }

    private function onSaveClick(e:Event):void {
        Dungeon.saveGame();
    }

    private function onLoadClick(e:Event):void {
        Dungeon.loadGame();
    }
}
