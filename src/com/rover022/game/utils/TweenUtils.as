package com.rover022.game.utils {
import com.rover022.game.tiles.DungeonTilemap;

import flash.geom.Point;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;

public class TweenUtils {
    public function TweenUtils() {
    }

    //Transitions.EASE_IN_OUT

    public static function move(target:DisplayObject, point:Point, type:String = Transitions.LINEAR, remove:Boolean = true):void {
        var tween:Tween = new Tween(target, 0.6, type);
        tween.moveTo(point.x * DungeonTilemap.SIZE, point.y * DungeonTilemap.SIZE);
        if (remove) {
            tween.onComplete = onComplete;
        }

        Starling.juggler.add(tween);

        function onComplete():void {
            target.removeFromParent();
        }
    }
}
}
