package test {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.scenes.InterlevelScene;
import com.rover022.game.scenes.StartScene;

import starling.events.Event;

import utils.MenuButton;

public class TestStartScene extends StartScene {
    public function TestStartScene() {
        super();
    }

    override public function create():void {
        super.create();
        var btn:MenuButton;

        btn = new MenuButton("加载");
        btn.x = btn.width;
        addChild(btn);
        btn.addEventListener(Event.TRIGGERED, onStartClick);
    }

    public static function initTestFunButton(_x:Number, _y:Number, _txt:String, onLoadClick:Function):MenuButton {
        var btn:MenuButton = new MenuButton(_txt);
        btn.x = _x;
        btn.y = _y;
        btn.addEventListener(Event.TRIGGERED, onLoadClick);
        return btn;
    }

    private function onStartClick(event:Event):void {
        startNewGame();
    }

    override public function startNewGame():void {
        //
        InterlevelScene.mode = InterlevelScene.DESCEND;
        //加载游戏数据
        Dungeon.loadGame("11.dat");
        //进入游戏场景
        MiniGame.switchScene(GameScene);
        MiniGame.scene.addChild(new WndTest());
    }
}
}

import com.rover022.game.Dungeon;
import com.rover022.game.levels.Level;
import com.rover022.game.ui.Window;

import starling.events.Event;

import test.TestStartScene;

import utils.MenuButton;

class WndTest extends Window {
    public function WndTest() {
        var btn:MenuButton = TestStartScene.initTestFunButton(0, 0, "加载游戏", onLoadClick);
        addChild(btn);
        var _h:Number = btn.height;
        btn = TestStartScene.initTestFunButton(0, _h, "保存游戏", onSaveClick);
        addChild(btn);

        btn = TestStartScene.initTestFunButton(0, 640 - _h, "加载关卡", onLoadLevelClick);
        addChild(btn);
        btn = TestStartScene.initTestFunButton(0, 640 - _h * 2, "保存关卡", onSaveLevelClick);
        addChild(btn);
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
