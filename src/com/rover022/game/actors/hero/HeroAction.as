package com.rover022.game.actors.hero {
import flash.geom.Point;

public class HeroAction {

    public static const Move:String = "Move";
    public static const Pickup:String = "Pickup";
    public static const OpenChest:String = "OpenChest";
    public static const Buy:String = "Buy";
    public static const Interact:String = "Interact";
    public static const Unlock:String = "Unlock";
    public static const Descend:String = "Descend";
    public static const Ascend:String = "Ascend";
    public static const Alchemy:String = "Alchemy";
    public static const Attack:String = "Attack";

    public var pos:Point;
    public var type:String;

    public function HeroAction(_type:String, _pos:Point) {
        this.type = _type;
        this.pos = _pos;
    }
}
}
