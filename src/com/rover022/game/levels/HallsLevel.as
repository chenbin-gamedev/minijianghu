package com.rover022.game.levels {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.actors.mobs.npcs.NPC;
import com.rover022.game.utils.Pathfinder;

import flash.geom.Point;
import flash.utils.getDefinitionByName;

public class HallsLevel extends RegularLevel {
    public function HallsLevel() {
        super();

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
        makeMob(new Point(5, 5));
//        makeMob(new Point(4, 5));

        //加入一个NPC
//        var npcClass:Class = getDefinitionByName("com.rover022.minigame.actors.npcs.OldMan") as Class;
//        var npcClass:Class = getDefinitionByName("com.rover022.game.actors.hero") as Class;
        var npcClass:Class = getDefinitionByName("com.rover022.game.actors.mobs.npcs.NPC") as Class;
        var npc:NPC = new npcClass();
        npc.pos = new Point(3, 5);
        mobs.push(npc);

        //
        function makeMob(brokenPos:Point):Mob {
            var mob:Mob = new Mob();
            mob.spawn(Dungeon.depth);
            mob.pos = brokenPos;
            mobs.push(mob);
            return mob;
        }
    }
}
}
