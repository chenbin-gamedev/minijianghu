package com.rover022.game.actors.hero {
import com.rover022.game.actors.Char;

public class CharClass {
    public static const WARRIOR:String = "WARRIOR";
    public static const MAGE:String = "MAGE";
    public static const ROGUE:String = "ROGUE";
    public static const HUNTRESS:String = "HUNTRESS";
    public var type:String = WARRIOR;

    public function CharClass() {
    }

    public function initHero(hero:Char, _type:String):Char {
        hero.heroClass = this;
        type = _type;
        initCommon(hero);
        switch (type) {
            case WARRIOR:
                initWarrior(hero);
                break;
            case MAGE:
                initMage(hero);
                break;
            case ROGUE:
                initRogue(hero);
                break;
            case HUNTRESS:
                initHuntress(hero);
                break;
        }
        return hero;
    }

    private static function initHuntress(hero:Char):void {

    }

    private static function initRogue(hero:Char):void {

    }

    private static function initMage(hero:Char):void {

    }

    private static function initWarrior(hero:Char):void {

    }

    private static function initCommon(hero:Char):void {

    }

}
}
