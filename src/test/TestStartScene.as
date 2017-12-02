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
        var btn:MenuButton = new MenuButton("test");
        addChild(btn);
        btn.addEventListener(Event.TRIGGERED, onStartClick);
    }

    private function onStartClick(event:Event):void {
        startNewGame();
    }

    override public function startNewGame():void {
        Dungeon.hero = null;
        InterlevelScene.mode = InterlevelScene.DESCEND;
        //进入游戏场景
        MiniGame.switchScene(GameScene);
    }
}
}
