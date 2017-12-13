package com.rover022.game.windows.wnditems {
import com.rover022.game.items.Item;
import com.rover022.game.ui.ItemSlot;
import com.rover022.game.utils.Bundlable;

import starling.display.Sprite;

public class GridLayoutSprite extends Sprite {
    public var w:int = 5;
    public var cell_size:Number;
    public var dataArray:Vector.<Bundlable>;

    public function GridLayoutSprite(c_width:Number, _w:int = 5, length:int = 20) {
        w = _w;
        this.cell_size = c_width;
    }

    /**
     * 插入item 到包裹 同时需要建立 itemSolt对象(不带数据修改)
     * @param item
     * @param index
     * @return
     */
    public function insetItemSolt(item:Item, index:int = -1):Boolean {
        item.makeSlot();
        if (index != -1) {
            resetPos(index, item);
            addChild(item.itemSlot);
            dataArray[index] = item;
            return true;
        }
        //不固定位置插入
        for (var i:int = 0; i < dataArray.length; i++) {
            if (dataArray[i] == null) {
                dataArray[i] = item;
                resetPos(i, item);
                addChild(item.itemSlot);
                return true
            }
        }
        return false;
    }

    public function get size():int {
        return dataArray.length;
    }

    public function getItem(item:Item):Item {
        for each (var cell:Item in dataArray) {
            if (cell == item) {
                return cell
            }
        }
        return null;
    }

    /**
     * 整理包裹
     */
    public function rescroe():void {

        for (var i:int = 0; i < dataArray.length - 1; i++) {
            var item:Item = dataArray[i] as Item;
            if (item == null) {
                dataArray[i] = dataArray[i + 1];
                dataArray[i + 1] = null;
                resetPos(i, dataArray[i] as Item);
//                continue;
            }
        }
    }

    /**
     * 重置坐标
     * @param i
     * @param item
     */
    private function resetPos(i:int, item:Item):void {
        if (item) {
            var a:int = (i % w);
            var b:int = int(i / w);
            item.itemSlot.x = a * cell_size;
            item.itemSlot.y = b * cell_size;
        }
    }

    /**
     * 移除带数据删除
     * @param item
     */
    public function removeFromLayOut(item:Item, index:int = -1):void {
        if (index == -1) {
            index = dataArray.indexOf(item);
        }
        if (index != -1) {
            dataArray[index] = null;
            removeChild(item.itemSlot);
            trace("移除", index);
        } else {
            trace("不在数组里 移除失败")
        }

    }

    /**
     * 总的设置
     * @param items
     */
    public function setDataArray(items:Vector.<Bundlable>):void {
        dataArray = items;
        for (var i:int = 0; i < dataArray.length; i++) {
            var item:Item = dataArray[i] as Item;
            if (item) {
                item.itemSlot = new ItemSlot(item);

                var a:int = (i % w);
                var b:int = int(i / w);
                item.itemSlot.x = a * cell_size;
                item.itemSlot.y = b * cell_size;

                addChild(item.itemSlot);
            }

        }
    }
}
}
