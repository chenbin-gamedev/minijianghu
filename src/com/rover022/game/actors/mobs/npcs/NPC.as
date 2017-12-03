package com.rover022.game.actors.mobs.npcs {

import com.rover022.game.actors.mobs.Mob;

import flash.geom.Point;

public class NPC extends Mob {
    public var quest:Quest = new Quest();

    public function NPC() {
        super();
        alignment = NEUTRAL;
        state = PASSIVE;
    }



    public function throwItem():void {

    }

    override public function beckon(cell:Point):void {

    }

    public function interact():Boolean {

        return true;
    }
}
}
