package com.rover022.game.actors.mobs {
import com.rover022.game.Dungeon;
import com.rover022.game.actors.Char;
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.Generator;
import com.rover022.game.items.Item;

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
    public static const mobdata:Array = [];
    {
        mobdata[0] = {name: "穿越者", skil: "ASAAA", HP: 6, HT: 2, ack: 6, des: "无限引导"};
        mobdata[1] = {name: "少  侠", skil: "AASAA", HP: 6, HT: 2, ack: 6, des: "每回合恢复MP"};
        mobdata[2] = {name: "大  侠", skil: "SASAA", HP: 7, HT: 2, ack: 6, des: "无反击攻击"};
        mobdata[3] = {name: "武  僧", skil: "BXABB", HP: 8, HT: 1, ack: 4, des: "防御致命一击"};
        mobdata[4] = {name: "大  师", skil: "ASSAA", HP: 8, HT: 1, ack: 5, des: "无限引导"};

        mobdata[5] = {name: "方  丈", skil: "SBBSB", HP: 8, HT: 2, ack: 6, des: "破攻攻击"};
        mobdata[6] = {name: "剑  手", skil: "SBBSA", HP: 5, HT: 1, ack: 6, des: "无限引导"};
        mobdata[7] = {name: "剑  客", skil: "SAASA", HP: 6, HT: 1, ack: 7, des: "无限引导"};
        mobdata[8] = {name: "剑  侠", skil: "ASAAA", HP: 6, HT: 2, ack: 6, des: "策略模仿"};

        mobdata[9] = {name: "刀  手", skil: "SABBA", HP: 6, HT: 1, ack: 5, des: "无限引导"};
        mobdata[10] = {name: "刀  客", skil: "SAABA", HP: 6, HT: 1, ack: 5, des: "无限引导"};
        mobdata[11] = {name: "刀  霸", skil: "SSAAA", HP: 7, HT: 1, ack: 6, des: "双枪攻击"};

        mobdata[12] = {name: "帮  众", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[13] = {name: "长  老", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "无限引导"};
        mobdata[14] = {name: "帮  主", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "致命攻击"};
        mobdata[15] = {name: "教  众", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[16] = {name: "护  法", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "奋战攻击"};
        mobdata[17] = {name: "教  主", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};

        mobdata[18] = {name: "霹雳手", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[19] = {name: "练毒者", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "无限引导"};
        mobdata[20] = {name: "金蛇君", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "致命攻击"};
        mobdata[21] = {name: "神雕侠", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[22] = {name: "酒剑仙", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "奋战攻击"};
        mobdata[23] = {name: "少镖头", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};

        mobdata[24] = {name: "飞狐侠", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[25] = {name: "血刀客", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "无限引导"};
        mobdata[26] = {name: "采花贼", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "致命攻击"};
        mobdata[27] = {name: "世  子", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[28] = {name: "少  主", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "奋战攻击"};
        mobdata[29] = {name: "公  子", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};

        mobdata[30] = {name: "神  医", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[31] = {name: "药  师", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "无限引导"};
        mobdata[32] = {name: "毒  手", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "致命攻击"};
        mobdata[33] = {name: "世  子", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[34] = {name: "恶  人", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "奋战攻击"};
        mobdata[35] = {name: "隐  士", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[36] = {name: "邪  客", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};

        mobdata[37] = {name: "女弟子", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[38] = {name: "尼  姑", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "无限引导"};
        mobdata[39] = {name: "师  太", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "致命攻击"};
        mobdata[40] = {name: "玉  女", skil: "ASAAA", HP: 5, HT: 1, ack: 5, des: "无限引导"};
        mobdata[41] = {name: "圣  女", skil: "ASAAA", HP: 5, HT: 1, ack: 6, des: "奋战攻击"};

        mobdata[42] = {name: "少  僧", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[43] = {name: "五  绝", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[44] = {name: "宗  师", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[45] = {name: "法  王", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[46] = {name: "掌  门", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[47] = {name: "摩天士", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[48] = {name: "仙  姐", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[49] = {name: "毒  物", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[50] = {name: "怪  物", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[51] = {name: "官  兵", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
        mobdata[52] = {name: "百  姓", skil: "ASAAA", HP: 6, HT: 1, ack: 6, des: "混乱攻击"};
    }

    public function Mob() {
        super();
        alignment = ENEMY;
        actPriority = 2;

        var obj:Object = getRandomDate();
        //
        name = obj.name;
        HP = obj.HP;
        HT = obj.HT;
        attackSkill = obj.ack;
    }

    private function getRandomDate():Object {
        var index:int = Math.random() * mobdata.length;
        return mobdata[index];
    }

    override protected function initDrawDebug(color:Number = 0xff0000):void {
        super.initDrawDebug(color);
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
        HP = HT = 15 + Dungeon.depth * 5;
        defenseSkill = 4 + Dungeon.depth;
        attackSkill = 4 + Dungeon.depth;
        updateSpriteState();
    }

    override public function die():void {
        trace("怪物死掉.", pos);
        Dungeon.hero.earnExp(EXP);
        var _index:int = Dungeon.level.mobs.indexOf(this);
        if (_index != -1) {
            Dungeon.level.mobs.removeAt(_index);
            removeFromParent(true);
            trace("怪物从数据库移除.");
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


