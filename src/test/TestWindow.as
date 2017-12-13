package test {
import com.bit101.components.ComboBox;
import com.bit101.components.HBox;
import com.bit101.components.PushButton;
import com.bit101.components.Window;
import com.rover022.game.Dungeon;
import com.rover022.game.items.Gold;
import com.rover022.game.items.Item;
import com.rover022.game.items.armor.Armor;
import com.rover022.game.items.food.Food;
import com.rover022.game.items.potions.Potion;
import com.rover022.game.items.weapon.Weapon;

import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;

public class TestWindow extends Window {
    private var itemcombox:ComboBox;

    public function TestWindow(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Window") {
        super(parent, xpos, ypos, title);

        setSize(320, 320);
        var hbox:HBox = new HBox(content);
        var pusb:PushButton = new PushButton(hbox, 0, 0, "additem", onadditemClick);
        itemcombox = new ComboBox(hbox);
        itemcombox.addItem(Armor);
        itemcombox.addItem(Weapon);
        itemcombox.addItem(Gold);
        itemcombox.addItem(Potion);
        itemcombox.addItem(Food);
        itemcombox.selectedIndex = 0;
        hasCloseButton = true;
        alpha = 0.8;
    }

    override protected function onClose(event:MouseEvent):void {
        parent.removeChild(this);
    }

    private function onadditemClick(e:MouseEvent = null):void {
        var className:Class = itemcombox.selectedItem as Class;
        var item:Item = new className();
        item.doPickUp(Dungeon.hero);
    }
}
}
