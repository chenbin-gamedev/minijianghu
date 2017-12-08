package com.rover022.game.utils {
import flash.display.BitmapData;
import flash.display.Sprite;

import starling.display.Button;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.text.TextField;
import starling.text.TextFormat;
import starling.textures.Texture;

public class DebugTool {
    public function DebugTool() {
    }

    public static function makeButton(txt:String, w:Number = 60, h:Number = 20, color:Number = 0xffffff):Button {

        var nBox:Sprite = new Sprite();
        nBox.graphics.beginFill(color, 1);
        nBox.graphics.drawRect(0, 0, w, h);
        nBox.graphics.endFill();

        var nBMP_D:BitmapData = new BitmapData(w, h, true, color);
        nBMP_D.draw(nBox);

        var nTxtr:Texture = Texture.fromBitmapData(nBMP_D, false, false);
        var btn:Button = new Button(nTxtr, txt);
        return (btn);
    }

    public static function makeImage(SIZE:Number, color:Number):Image {
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

    public static function makeRectImage(SIZE:Number, color:Number):Image {
        var f_size:int = SIZE - 1;
        var nBox:Sprite = new Sprite();
        nBox.graphics.beginFill(color, 1);
        nBox.graphics.drawRect(0, 0, f_size, f_size);
        nBox.graphics.drawRect(4, 4, f_size - 8, f_size - 8);
        nBox.graphics.endFill();

        var nBMP_D:BitmapData = new BitmapData(f_size, f_size, true, 0xffffff);
        nBMP_D.draw(nBox);

        var nTxtr:Texture = Texture.fromBitmapData(nBMP_D, false, false);
        var img:Image = new Image(nTxtr);
        return (img);
    }

    public static function makeText(_p:starling.display.Sprite, _w:int, _h:int, _txt:String, _x:int = 0, _y:int = 0):TextField {
        var tf:TextFormat = new TextFormat();
        tf.size = 9;
        tf.color = 0;
        var txt:TextField = new TextField(_w, _h, _txt, tf);
        _p.addChild(txt);
        txt.x = _x;
        txt.y = _y;
        return txt;
    }
}
}
