package com.rover022.game.actors.mobs {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.Generator;
import com.rover022.game.items.Item;
import com.rover022.game.utils.Bundle;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

/**
 * 怪物模型
 */
public class Mob extends Char {
    //睡觉逻辑
    public var SLEEPING:AiState = new Sleepiing(this);
    //捕猎逻辑
    public var HUNTING:AiState = new Hunting(this);
    //随机逻辑
    public var WANDERING:AiState = new Wandering(this);
    //逃跑逻辑
    public var FLEEING:AiState = new Fleeing(this);
    //被动逻辑
    public var PASSIVE:AiState = new Passive(this);
    public var state:AiState = HUNTING;
//    public var SLEEPING:AiState = new Sleepiing();
    public var target:int = 1;
//    public var defenseSkill:int = 0;
    public var EXP:int = 1;
    public var maxLv1:int = Hero.MAX_LEVEL;

    public var enemySeen:Boolean;
    public var alerted:Boolean = false;
    private var level:int;
    //掉落物品类型
    public var loot:Object = null;
    //掉落道具的机会
    public var lootChance:Number = 0.1;

    //

    public function Mob() {
        super();
        alignment = ENEMY;
        actPriority = 2;
    }

    override protected function initDrawDebug():void {
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(SIZE, 0xff0000));
        }
    }

    override public function act():Boolean {

        trace(this, state, "思考");
        var enemy:Char = chooseEnemy();
        if (enemy.isAlive()) {
            state.act();
        }
        return false;
    }

    /**
     * 寻找敌人
     * @return
     */
    public function chooseEnemy():Char {
        return Dungeon.hero;
    }

    public function moveSprite(from:int, to:int):void {

    }

    public function getFurther(target:int):Boolean {
        return false;
    }

    public function attackDelay():int {
        return 1;
    }

//    public function doAttack(enemy:Char):Boolean {
//        var tween:Tween;
//        if (type == CharClass.WARRIOR) {
//            tween = new Tween(this, Actor.gameSpeed);
//            tween.moveTo(enemy.x, enemy.y);
//            tween.reverse = true;
//            tween.repeatCount = 2;
//            Starling.juggler.add(tween);
//        } else {
//            shoot(enemy, rangeWeapon);
//        }
//        return true;
//    }



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
        trace("怪物死掉.", pos);
        var _index:int = Dungeon.level.mobs.indexOf(this);
        if (_index != -1) {
            Dungeon.level.mobs.removeAt(_index);
            removeFromParent(true);
            trace("怪物从数据库移除.")
            //
            var item:Item = createLoot();
            if (item) {
                trace("怪物掉落道具.", item, pos);
                Dungeon.level.drop(item, pos);
            } else {
                trace("怪物没有掉落道具.")
            }
        } else {
            trace("奇怪 怪物群没找到这个", this);
        }
    }

    /**
     * 创建掉落的道具
     * @return
     */
    public function createLoot():Item {
        var item:Item;
        if (loot is String) {
            item = Generator.randomCategory(loot as String);
        } else if (loot is Class) {
            item = Generator.randomWeapon();
        } else if (loot is Item) {
            item = loot as Item;
        } else {
            item = Generator.randomItem();
        }
        return item;
    }

    /**
     * 基础寻路
     * @param enemy
     * @return
     */
    public function getNextPos(enemy:Char):Point {
        var nextP:Point;
        nextP = new Point(pos.x, pos.y);
        if (enemy.pos.x != this.pos.x) {
            nextP.x += (this.pos.x - enemy.pos.x) > 0 ? -1 : 1;
        }
        if (Dungeon.level.canPassable(nextP)) {
            //直接赋值
            pos = nextP;
            return nextP;
        }
        //y轴判断
        nextP = new Point(pos.x, pos.y);
        if (enemy.pos.y != this.pos.y) {
            nextP.y += (this.pos.y - enemy.pos.y) > 0 ? -1 : 1;
        }
        if (Dungeon.level.canPassable(nextP)) {
            //直接赋值
            pos = nextP;
            return nextP;
        } else {
            //y点不能移动的时候尝试左右移动一格去寻找hero
        }
        return null;
    }

//    /**
//     * 变种版寻路
//     * @param enemy
//     * @return
//     */
//    public function getNextPos(enemy:Char):Point {
//        var nextP:Point;
//        nextP = new Point(pos.x, pos.y);
//        var dis_x:int = Math.abs(this.pos.x - enemy.pos.x);
//        var dis_y:int = Math.abs(this.pos.y - enemy.pos.y);
//        if (dis_x > dis_y) {
//            //如果x轴距离过大 先移动x轴逻辑
//        } else {
//
//        }
//
//        if (enemy.pos.x != this.pos.x) {
//            nextP.x += (this.pos.x - enemy.pos.x) > 0 ? -1 : 1;
//        }
//        if (Dungeon.level.canPassable(nextP)) {
//            //直接赋值
//            pos = nextP;
//            return nextP;
//        }
//        //y轴判断
//        nextP = new Point(pos.x, pos.y);
//        if (enemy.pos.y != this.pos.y) {
//            nextP.y += (this.pos.y - enemy.pos.y) > 0 ? -1 : 1;
//        }
//        if (Dungeon.level.canPassable(nextP)) {
//            //直接赋值
//            pos = nextP;
//            return nextP;
//        } else {
//            //y点不能移动的时候尝试左右移动一格去寻找hero
//        }
//        return null;
//    }

//    /**
//     * A*寻路
//     * @param enemy
//     * @return
//     */
//    public function getNextPos(enemy:Char):Point {
//        var _path:Array = Level.pathfinder.getPath(this.pos, enemy.pos);
//        trace(_path);
//        if (_path) {
//            return _path[0];
//        } else {
//            return null;
//        }
//    }
}
}

import com.rover022.game.actors.Char;
import com.rover022.game.actors.mobs.Mob;

import flash.geom.Point;

class AiState {
    public var owner:Mob;

    public function AiState(mob:Mob) {
        owner = mob;
    }

    public function act(enemyInFOV:Boolean = true, justAlerted:Boolean = true):void {

    }
}
class Sleepiing extends AiState {

    function Sleepiing(mob:Mob) {
        super(mob);
    }
}
class Hunting extends AiState {

    override public function act(enemyInFOV:Boolean = true, justAlerted:Boolean = true):void {
        super.act(enemyInFOV, justAlerted);
        var enemy:Char = owner.chooseEnemy();
        owner.enemy = enemy;
        if (enemy == null) {
            owner.state = owner.WANDERING;
            return;
        }
        if (owner.enemy.isAlive()) {
            if (owner.canAttack(owner.enemy)) {
                trace("怪物攻击");
                owner.doAttack(enemy);
            } else {
                //怪物先改变自己的pos值 然后播放动画不会造成后面的怪物移动位置冲突
                var oldPos:Point = owner.pos;
                if (owner.getNextPos(enemy)) {
                    trace("怪物移动", owner.name, "oldPos", oldPos, "newPos", owner.pos);
                    owner.move(owner.pos);
                } else {
                    trace("怪物无法移动");
                }
            }
        }
    }

    function Hunting(mob:Mob) {
        super(mob);
    }
}
class Wandering extends AiState {

    function Wandering(mob:Mob) {
        super(mob);
    }
}
class Fleeing extends AiState {

    function Fleeing(mob:Mob) {
        super(mob);
    }
}
class Passive extends AiState {

    function Passive(mob:Mob) {
        super(mob);
    }
}


