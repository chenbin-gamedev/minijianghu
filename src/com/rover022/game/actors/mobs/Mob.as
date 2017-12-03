package com.rover022.game.actors.mobs {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

/**
 * 怪物模型
 */
public class Mob extends Char {
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

    public var enemySeen:Boolean;
    public var alerted:Boolean = false;
    private var level:int;

    //

    public function Mob() {
        super();
        alignment = ENEMY;
        actPriority = 2;
//        name = Messages.get(this.toString(), "name");
    }

    override protected function initDrawDebug():void {
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(SIZE, 0xff0000));
        }
    }

    override public function storeInBundle():void {
        super.storeInBundle();
    }

    override public function act():Boolean {
        return false;
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
        x = SIZE * pos.x;
        y = SIZE * pos.y;
        return true;
    }

    public function yell(src:String):void {

    }

    public function beckon(pos:Point):void {

    }

    /**
     * 观察地下城 自身的血量 魔法和攻击力 防御力做出改变
     * @param level
     */
    public function spawn(level:int):void {
        this.level = level;
        HT = (2 + level) * 4;
        //defenseSkill = 9 + level;
    }

    override public function die():void {
        var _index:int = Dungeon.level.mobs.indexOf(this);
        if (_index != -1) {
            Dungeon.level.mobs.removeAt(_index);
            removeFromParent(true);
        } else {
            trace("奇怪 怪物群没找到这个", this);
        }
        //super.die();
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
