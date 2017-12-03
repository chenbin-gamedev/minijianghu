package com.rover022.game.tiles {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.actors.Actor;
import com.rover022.game.utils.ArrayUtil;
import com.rover022.game.utils.DebugTool;

import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;

public class Tile extends Sprite {

    public var array01:Array = ["map001", "map002", "map003", "map004", "map005", "map006", "map007", "map008"];
    public var array02:Array = ["map010", "map011", "map012", "map013", "map014", "map015", "map016", "map017"];
    public var array03:Array = ["map130", "map131", "map132", "map133", "map134", "map135", "map136", "map137"];

    public function Tile() {
        super();
//        if (Dungeon.isdebug) {
//            addChild(DebugTool.makeImage(Actor.SIZE, 0x0000FF));
//        }
        makeUI();
    }

    public function makeUI():void {
        var _array:Array;
        switch (Dungeon.depth % 3) {
            case 1:
                _array = array01;
                break;
            case 2:
                _array = array02;
                break;
            default:
                _array = array03;
                break;
        }
        var _t_name:String = ArrayUtil.getRandom(_array);
//        MiniGame.assets.get
        var textTure:Texture = MiniGame.assets.getTexture(_t_name);
        var image:Image = new Image(textTure);
        addChild(image);
    }

}

}
