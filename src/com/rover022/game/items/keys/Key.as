package com.rover022.game.items.keys {
import com.rover022.game.actors.hero.Hero;
import com.rover022.game.items.Item;
import com.rover022.game.journal.Notes;
import com.rover022.game.scenes.GameScene;

public class Key extends Item {
    public function Key() {
        super();
        stackable = true;
        unique = true;
    }


    override public function doPickUp(hero:Hero):Boolean {
        GameScene.pickUp(this, hero.pos);
        Notes.add(this);
        hero.spendAndNext(TIME_TO_PICK_UP);
        GameScene.updataKeyDisplay();
        return super.doPickUp(hero);
    }
}
}
