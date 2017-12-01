package com.rover022.game.actors.mobs.npcs {
import com.rover022.game.actors.mobs.Mob;

public class NPC extends Mob {
    public var quest:Quest = new Quest();

    public function NPC() {
        super();
        alignment = NEUTRAL;
        state = PASSIVE;
    }

    public function throwItem():void {

    }

    public function beckon(cell:int):void {

    }

    public function interact():Boolean {
        return true;
    }
}
}
