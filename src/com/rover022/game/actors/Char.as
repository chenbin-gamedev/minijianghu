package com.rover022.game.actors {
import com.rover022.game.Dungeon;
import com.rover022.game.MiniGame;
import com.rover022.game.actors.buffs.Buff;
import com.rover022.game.tiles.DungeonTilemap;
import com.rover022.game.utils.DebugTool;

import flash.geom.Point;

import starling.animation.Tween;
import starling.core.Starling;

public class Char extends Actor {
    public var enemy:Char;
    public var pos:Point = new Point();
//    public var sprite:CharSprite;
//    public var name:String = "mod";

    //优先级
    public var actPriority:int;
    //血量
    public var HP:int;
    //魔法
    public var HT:int;
    public var SHLD:int;
    //攻击力
    public var attackSkill:int;
    //防御力
    public var defenseSkill:int;
    //移动速度
    public var baseSpeed:Number = 0.5;
    //行走路径
    public var path:Array;
    //发呆
    public var paralused:int = 0;
    public var rooted:Boolean = false;
    public var flying:Boolean = false;
    //敌人
    public static var ENEMY:String = "ENEMY";
    //中立
    public static var NEUTRAL:String = "NEUTRAL";
    //盟友
    public static var ALLY:String = "ALLY";

    public var alignment:String = NEUTRAL;

    public var buffs:Array = [];

    public function Char() {
        pos = new Point();
        HP = 1;
        HT = 1;
        attackSkill = 1;
        defenseSkill = 0;
        initDrawDebug();
    }

    protected function initDrawDebug():void {
        if (Dungeon.isdebug) {
            addChild(DebugTool.makeImage(SIZE, 0xff00ff));
        }
    }

    public function attack(enemy:Char):Boolean {
        if (enemy == null || !enemy.isAlive()) {

            return false;
        } else {
            hit(this, enemy, false);
        }
//        boolean visibleFight = Dungeon.level.heroFOV[pos] || Dungeon.level.heroFOV[enemy.pos];
//
//        if (hit( this, enemy, false )) {
//
//            // FIXME
//            int dr = this instanceof Hero && ((Hero)this).rangedWeapon != null && ((Hero)this).subClass ==
//            HeroSubClass.SNIPER ? 0 : enemy.drRoll();
//
//            int dmg;
//            Preparation prep = buff(Preparation.class);
//            if (prep != null){
//                dmg = prep.damageRoll(this, enemy);
//            } else {
//                dmg = damageRoll();
//            }
//            int effectiveDamage = Math.max( dmg - dr, 0 );
//
//            effectiveDamage = attackProc( enemy, effectiveDamage );
//            effectiveDamage = enemy.defenseProc( this, effectiveDamage );
//
//            if (visibleFight) {
//                Sample.INSTANCE.play( Assets.SND_HIT, 1, 1, Random.Float( 0.8f, 1.25f ) );
//            }
//
//            if (enemy == Dungeon.hero) {
//                Dungeon.hero.interrupt();
//            }
//
//            // If the enemy is already dead, interrupt the attack.
//            // This matters as defence procs can sometimes inflict self-damage, such as armor glyphs.
//            if (!enemy.isAlive()){
//                return true;
//            }
//
//            //TODO: consider revisiting this and shaking in more cases.
//            float shake = 0f;
//            if (enemy == Dungeon.hero)
//                shake = effectiveDamage / (enemy.HT / 4);
//
//            if (shake > 1f)
//            Camera.main.shake( GameMath.gate( 1, shake, 5), 0.3f );
//
//            enemy.damage( effectiveDamage, this );
//
//            if (buff(FireImbue.class) != null)
//                buff(FireImbue.class).proc(enemy);
//            if (buff(EarthImbue.class) != null)
//                buff(EarthImbue.class).proc(enemy);
//
//            enemy.sprite.bloodBurstA( sprite.center(), effectiveDamage );
//            enemy.sprite.flash();
//
//            if (!enemy.isAlive() && visibleFight) {
//                if (enemy == Dungeon.hero) {
//
//                    Dungeon.fail( getClass() );
//                    GLog.n( Messages.capitalize(Messages.get(Char.class, "kill", name)) );
//
//                } else if (this == Dungeon.hero) {
//                    GLog.i( Messages.capitalize(Messages.get(Char.class, "defeat", enemy.name)) );
//                }
//            }
//
//            return true;
//
//        } else {
//
//            if (visibleFight) {
//                String defense = enemy.defenseVerb();
//                enemy.sprite.showStatus( CharSprite.NEUTRAL, defense );
//
//                Sample.INSTANCE.play(Assets.SND_MISS);
//            }
//
//            return false;
//
//        }

        return true;
    }

    /**
     * 返回是否死亡
     * @param attacker
     * @param defender
     * @param magic
     * @return
     */
    public static function hit(attacker:Char, defender:Char, magic:Boolean):Boolean {
        var acuRoll:int = attacker.attackSkill;
        var defRoll:int = defender.defenseSkill;
        var dmg:int = (acuRoll - defRoll);
        if (dmg < 0) {
            dmg = 0;
        }
        defender.HP -= dmg;
        if (defender.HP <= 0) {
            defender.die();
        }
        trace("伤害值:", dmg, "剩余HP", defender.HP);
        return defender.HP <= 0;
    }

    public function attackProc(enemy:Char, damage:int):int {
        return 0;
    }

    public function defenseProc(enemy:Char, damage:int):int {
        return 0;
    }

    public function damage(dmg:int, src:Object):void {
        if (!isAlive() || dmg < 0) {
            return;
        }

    }

    override public function addBuff(buff:Buff):void {
        buffs.push(buff);
    }

    override public function removeBuff(buff:Buff):void {
        var _index:Number = buffs.indexOf(buff);
        if (_index != -1) {
            buffs.removeAt(_index);
        }
    }

    override public function onRemove():void {
        super.onRemove()
        for each (var buff:Buff in buffs) {
            buff.deach();
        }
    }

    public function updateSpriteState():void {
        for each (var buff:Buff in buffs) {
            buff.fx(true);
        }
    }

    public function destroy():void {
        HP = 0;
        Actor.remove(this);
    }

    public function isAlive():Boolean {
        if (HP > 0) {
            return true;
        }
        return false;
    }

    public function move(sept:Point):void {
        pos = sept;
        var f_x:int = DungeonTilemap.SIZE * pos.x;
        var f_y:int = DungeonTilemap.SIZE * pos.y;
        var tween:Tween = new Tween(this, baseSpeed);
        tween.moveTo(f_x, f_y);
        tween.onComplete = onCompleteTweener;
        Starling.juggler.add(tween);

    }

    public function onCompleteTweener():void {

    }

    public function onCompleteAnimation():void {

    }

    public function distance(other:Char):int {
        return MiniGame.distance(pos, other.pos);
    }

    public function onAttackComplete():void {
        next();
    }

    public function onOperateComplete():void {
        next();
    }

    public function storeInBundle():void {

    }

    public function immunities():Array {
        return buffs;
    }

    public function die():void {

    }
}
}
