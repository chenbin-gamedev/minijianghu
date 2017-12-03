package com.rover022.game.actors.hero {
import com.rover022.game.actors.Char;

import flash.geom.Point;

public class HeroAction {

    //移动
    public static const Move:String = "Move";
    //拾取道具动作
    public static const PickUp:String = "PickUp";
    //开宝箱动作
    public static const OpenChest:String = "OpenChest";
    //点击商店动作
    public static const Buy:String = "Buy";
    //点击npc动作
    public static const Interact:String = "Interact";
    //开锁动作
    public static const Unlock:String = "Unlock";
    //去下一个深度的地下城动作
    public static const Descend:String = "Descend";
    //去上一个深度的地下城动作
    public static const Ascend:String = "Ascend";
    //炼金术
    public static const Alchemy:String = "Alchemy";
    //攻击动作
    public static const Attack:String = "Attack";

    public var pos:Point;
    public var type:String;
    public var target:Char;

    public function HeroAction(_type:String, _pos:Point) {
        this.type = _type;
        this.pos = _pos;
    }
}
}
