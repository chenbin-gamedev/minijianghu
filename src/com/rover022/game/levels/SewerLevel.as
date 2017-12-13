package com.rover022.game.levels {
public class SewerLevel extends RegularLevel {
    public function SewerLevel() {
        super();

    }

    override public function onCreate():void {
        createRandomMap();
        trace("SewerLevel...建立随机地图");
    }

}
}
