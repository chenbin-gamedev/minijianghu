package com.rover022.game.actors.hero {
public class HeroClass {
    public static const WARRIOR:String = "WARRIOR";
    public static const MAGE:String = "MAGE";
    public static const ROGUE:String = "ROGUE";
    public static const HUNTRESS:String = "HUNTRESS";
    public var type:String = WARRIOR;

    public function HeroClass() {
    }

    public function initHero(hero:Hero, _type:String):Hero {
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

    private static function initHuntress(hero:Hero):void {

    }

    private static function initRogue(hero:Hero):void {

    }

    private static function initMage(hero:Hero):void {

    }

    private static function initWarrior(hero:Hero):void {

    }

    private static function initCommon(hero:Hero):void {

    }

}
}
