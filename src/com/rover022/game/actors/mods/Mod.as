package com.rover022.game.actors.mods {
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.messages.Messages;

/**
 * 怪物模型
 */
public class Mod extends Char {
    public var SLEEPING:AiState = new Sleepiing();
    public var HUNTING:AiState = new Hunting();
    public var WANDERING:AiState = new Wandering();
    public var FLEEING:AiState = new Fleeing();
    public var PASSIVE:AiState = new Passive();
    public var state:AiState = SLEEPING;
//    public var SLEEPING:AiState = new Sleepiing();
    public var target:int = 1;
//    public var defenseSkill:int = 0;
    public var EXP:int = 1;
    public var maxLv1:int = Hero.MAX_LEVEL;
    //
    public var enemy:Char;
    public var enemySeen:Boolean;
    public var alerted:Boolean = false;

    //


    public function Mod() {
        super();
        alignment = ENEMY;
        actPriority = 2;
        name = Messages.get(this, "name");
    }

    override public function storeInBundle():void {
        super.storeInBundle();
    }

    public function act():Boolean {

    }

    public function chooseEnemy():Char {
        return null;
    }

    public function moveSprite(from:int, to:int):void {

    }

    public function canAttack():Boolean {
        return true;
    }

    public function getCloser(target:int):Boolean {
        return false;
    }

    public function getFurther(target:int):Boolean {
        return false;
    }

    public function attackDelay():int {
        return 1;
    }

    public function doAttack(enemy:Char):Boolean {
        return true;
    }

    public function reset():Boolean {
        return true;
    }

    public function yell(src:String):void {

    }

}
}
class AiState {

}
class Sleepiing extends AiState {

}
class Hunting extends AiState {

}
class Wandering extends AiState {

}
class Fleeing extends AiState {

}
class Passive extends AiState {

}
