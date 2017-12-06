package com.rover022.game.scenes {
import com.rover022.game.Dungeon;
import com.rover022.game.Statistics;
import com.rover022.game.actors.Actor;
import com.rover022.game.levels.Level;
import com.rover022.game.levels.rooms.special.SpecialRoom;
import com.rover022.game.ui.GameLog;

import flash.geom.Point;

/**
 * 关卡选择场景
 * 1类游戏 独立的游戏场景
 * 2类游戏 作为游戏内弹出面板使用关卡选择器 不使用该类;
 */
public class InterlevelScene extends PixelScene {
    public static const DESCEND:String = "DESCEND";
    public static const ASCEND:String = "ASCEND";
    public static const CONTINUE:String = "CONTINUE";
    public static const RESURRECT:String = "RESURRECT";
    public static const RETURN:String = "RETURN";
    public static const FALL:String = "FALL";
    public static const RESET:String = "RESET";
    public static const NONE:String = "NONE";

    public static var fallIntoPit:Boolean;
    public static var returnDepth:int;
    public static var returnPos:int;
    public static var noStory:Boolean = false;
    public static var mode:String = NONE;

    public function InterlevelScene() {
        super();
    }

    override public function create():void {
        super.create();
    }

    public function ascend():void {
        var level:Level;
        if (Dungeon.depth >= Statistics.deepesFloor) {
            level = Dungeon.newLevel();
        } else {
            Dungeon.depth++;
            level = Dungeon.loadLevel();
        }
        Dungeon.switchLevel(level, level.exit);
    }

    public function descend():void {
        var level:Level;
        if (Dungeon.hero == null) {
            Dungeon.init();
        }
        if (Dungeon.depth >= Statistics.deepesFloor) {
            level = Dungeon.newLevel();
        } else {
            Dungeon.depth++;
            level = Dungeon.loadLevel( );
        }
        Dungeon.switchLevel(level, level.entrance);
    }

    public function returnTo():void {
        var level:Level;
        if (Dungeon.depth >= Statistics.deepesFloor) {
            level = Dungeon.newLevel();
        } else {
            Dungeon.depth++;
            level = Dungeon.loadLevel( );
        }
        Dungeon.switchLevel(level, level.entrance);
    }

    public function fall():void {
        Actor.fixTime();
        Dungeon.saveAll();
        var level:Level;
        if (Dungeon.depth >= Statistics.deepesFloor) {
            level = Dungeon.newLevel();
        } else {
            Dungeon.depth++;
            level = Dungeon.loadLevel( );
        }
        Dungeon.switchLevel(level, level.fallCell(fallIntoPit));
    }

    /**
     * 重置...在地下城
     */
    public function reset():void {
        Actor.fixTime();
        SpecialRoom.resetPitRoom(Dungeon.depth + 1);
        Dungeon.depth--;
        var level:Level = Dungeon.newLevel();
        Dungeon.switchLevel(level, level.entrance);
    }

    /**
     * 加载外部数据装配地下城...在地下城
     */
    public function restore():void {
        Actor.fixTime();
        GameLog.wipe();

        var fileName:String = Dungeon.gameFile(StartScene.curClass);
        Dungeon.loadGame(fileName);
        if (Dungeon.depth == -1) {
            Dungeon.switchLevel(Dungeon.loadLevel( ), new Point());
        } else {
            var level:Level = Dungeon.loadLevel( );
            Dungeon.switchLevel(level, Dungeon.hero.pos);
        }
    }

    /**
     * 复活在..地下城
     */
    public function resurrect():void {
        Actor.fixTime();
        if (Dungeon.level.locked) {
            Dungeon.hero.resurrect(Dungeon.depth);
            Dungeon.depth--;
            var level:Level = Dungeon.newLevel();
            Dungeon.switchLevel(level, level.entrance);
        } else {
            Dungeon.hero.resurrect(-1);
            Dungeon.resetLevel();
        }
    }
}
}
