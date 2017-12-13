package com.rover022.game.levels {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.blobs.Blob;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.utils.Pathfinder;

import flash.geom.Point;

import utils.PointUtil;

public class RegularLevel extends Level {
    public function RegularLevel() {
        super();
        onCreate()
    }

    public function onCreate():void {

    }

    public function createRandomMap():void {
        entrance = getMapRandPoint(new Point(7, 7));
        exit = getMapRandPoint(entrance);
        setSize(6, 6);
        map = [
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0]];
        pathfinder = new Pathfinder();
        pathfinder.loadMap(map, 6, 6);
        //
        mobs = [];
        var modsNum:int = 3;
        for (var i:int = 0; i < modsNum; i++) {
            var point:Point = getEmptyPoint();
            makeMobSprite(point);
        }
    }

    /**
     * 获取随机一点
     * @param mubiao  随机点不会和这一点重复
     * @return
     */
    public function getMapRandPoint(mubiao:Point):Point {
        while (true) {
            var a:int = Math.random() * 6;
            var b:int = Math.random() * 6;
            var fP:Point = new Point(a, b);
            if (PointUtil.equit(fP, mubiao)) {
                continue
            }
            return fP;
        }
        return null;
    }

    public function makeMobSprite(brokenPos:Point):Mob {
        var mob:Mob = new Mob();
        mob.spawn(Dungeon.depth);
        mob.pos = brokenPos;
        mobs.push(mob);
        return mob;
    }

    public function getEmptyPoint():Point {
        while (true) {

            var a:int = Math.random() * 6;
            var b:int = Math.random() * 6;
            var fP:Point = new Point(a, b);
            var isSame:Boolean = false;
            for each (var char:Char in mobs) {
                if (PointUtil.equit(fP, char.pos)) {
                    isSame = true;
                    break;
                }
            }
            if (isSame) {
                continue;
            }
            for each (var blob:Blob in blobs) {
                if (PointUtil.equit(fP, blob.pos) == false) {
                    isSame = true;
                    break;
                }
            }
            if (isSame) {
                continue;
            }
            if (PointUtil.equit(fP, entrance) || PointUtil.equit(fP, exit)) {
                continue;
            }
            return fP;
        }
        return null;
    }

}
}
