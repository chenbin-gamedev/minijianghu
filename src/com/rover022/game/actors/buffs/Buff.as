package com.rover022.game.actors.buffs {
import com.rover022.game.actors.Actor;
import com.rover022.game.actors.Char;

public class Buff extends Actor {
    public var target:Char;

    public function Buff() {
        super();
    }

    public function attachTo(_target:Char):Boolean {
        if (_target.immunities().indexOf(name) != -1) {
            return false;
        }
        target = _target;
        _target.addBuff(this);
        return true;
    }

    public function fx(b:Boolean):void {

    }

    public function deach():void {

    }

    public function heroMessage():String {
        return null;
    }

    public function desc():String {
        return null;
    }


}
}
