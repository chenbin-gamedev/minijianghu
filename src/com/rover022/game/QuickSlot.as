package com.rover022.game {
import com.rover022.game.items.Item;



public class QuickSlot {
    public var dictArray:Array = new Array(SIZE);

    public function QuickSlot() {

    }

    public function reset():void {
        dictArray = new Array(SIZE);
    }

    public function setSlot(id:int, item:Item):void {
        dictArray[id] = item;
    }

    public function clearSlot(id:int):void {
        dictArray[id] = null;
    }

    public function clearItem(item:Item):void {
        if (contains(item)) {
            clearSlot(getSlot(item));
        }
    }

    public function contains(item:Item):Boolean {
        for each (var _item:Item in dictArray) {
            if (_item == item) {
                return true
            }
        }
        return false;
    }

    public function getSlot(item:Item):int {
        for (var i:int = 0; i < SIZE; i++) {
            if (dictArray[i] == item) {
                return i;
            }
        }
        return -1;
    }

    public function replacePlaceholder(item:Item):void {

    }

    public function convertToPlaceholder(item:Item):void {

    }

    public function randomNonePlaceholder():Item {
        var index:Number = int(Math.random() * SIZE);
        return dictArray[index];
    }

    public function storePlaceholders():void {

    }

    public function restorePlaceholders():void {

    }

    public static var SIZE:int = 8;

    public function getItem(id:int):Item {
        return dictArray[id];
    }

}
}
