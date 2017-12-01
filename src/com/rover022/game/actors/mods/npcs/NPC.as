package com.rover022.game.actors.mods.npcs {
import com.rover022.game.actors.mods.Mod;

public class NPC extends Mod {
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
