package com.rover022.game.scenes {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.actors.hero.HeroClass;

/**
 * 游戏开始场景
 */
public class StartScene extends PixelScene {
    public static var curClass:HeroClass;

    public function StartScene() {
        super();
    }

    override public function create():void {

    }

    /**
     * 开始按键被点击时候触发
     */
    public function startNewGame():void {
        Dungeon.hero = null;
        InterlevelScene.mode = InterlevelScene.DESCEND;
//        MiniGame.switchScene(InterlevelScene);
        MiniGame.switchScene(GameScene);
    }


    public function updateClass():void {

    }
}
}
