package com.rover022.game.utils {
import flash.display.BitmapData;
import flash.display.Sprite;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.textures.Texture;

public class DebugTool {
    public function DebugTool() {
    }

    public static function makeImage(SIZE:Number, color:Number):DisplayObject {
        var f_size:int = SIZE - 1;
        var nBox:Sprite = new Sprite();
        nBox.graphics.beginFill(color, 1);
        nBox.graphics.drawRect(0, 0, f_size, f_size);
        nBox.graphics.endFill();

        var nBMP_D:BitmapData = new BitmapData(f_size, f_size, true, 0xffffff);
        nBMP_D.draw(nBox);

        var nTxtr:Texture = Texture.fromBitmapData(nBMP_D, false, false);
        var img:Image = new Image(nTxtr);
        return (img);
    }
}
}
