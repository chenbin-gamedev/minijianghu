package com.rover022.game.effects {
import com.rover022.game.actors.Char;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.utils.TweenUtils;

import starling.text.TextField;
import starling.text.TextFormat;

public class FloattingText extends TextField {
    public function FloattingText(width:int, height:int, text:String = "", format:TextFormat = null) {
        super(width, height, text, format);
    }

    public static function show(char:Char, dmg:int):void {
        var text:FloattingText = new FloattingText(char.width, 20, dmg.toString());
        text.x = char.x;
        text.y = char.y;
        GameScene.cellSelector.addChild(text);
        TweenUtils.move(text, char.pos);
    }
}
}
