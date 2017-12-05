package com.rover022.game.items.weapon.missiles {
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.weapon.Weapon;
import com.rover022.game.tiles.DungeonTilemap;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

/**
 * 会发射一个飞行道具飞向敌人
 * 导弹武器
 *
 */
public class MissileWeapon extends Weapon {
    public var baseSpeed:Number = 0.5;

    public function MissileWeapon() {
        super();
    }

    /**
     * @inheritDoc
     *
     */
    override public function throwPos(user:Hero, dst:Point):void {
        var disPlay:DisplayObject = getWeaponBullet();
        var _parent:DisplayObjectContainer = user.parent;
        _parent.addChild(disPlay);
        var tween:Tween = new Tween(disPlay, baseSpeed);
        tween.moveTo(dst.x * DungeonTilemap.SIZE, dst.y * DungeonTilemap.SIZE);
        tween.onComplete = onCompleteFun;
        Starling.juggler.add(tween);

        function onCompleteFun():void {
            disPlay.removeFromParent();
        }

        super.throwPos(user, dst);
    }

    public function getWeaponBullet():DisplayObject {
        return DebugTool.makeImage(20, 0xff0000);
    }

}
}
