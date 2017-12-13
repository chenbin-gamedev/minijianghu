package com.rover022.game.actors.mobs.npcs {

import com.rover022.game.actors.mobs.Mob;
import com.rover022.game.scenes.GameScene;
import com.rover022.game.windows.WndTalkMessage;

import flash.geom.Point;

public class NPC extends Mob {
    public var quest:Quest = new Quest();

    public var talkArray:Array = [];

    public function NPC() {
        super();
        alignment = NEUTRAL;
        state = PASSIVE;
        talkArray.push("昨天天很黑");
        talkArray.push("今天很好");
        talkArray.push("明天很好");
    }

    public function throwItem():void {

    }

    override public function beckon(cell:Point):void {

    }

    /**
     * npc 活动
     * 基本活动类型就是对话
     * @return
     */
    public function interact():Boolean {
        var wnd:WndTalkMessage = new WndTalkMessage();
        wnd.creatCloseBotton();
        wnd.npc = this;
        GameScene.show(wnd);
        //
        return true;
    }

    public function getNextTalk():String {
        return "";
    }

    public function getName():String {
        return "null"
    }

    public function getTalk(count:int):String {
        if (count < talkArray.length) {
            return talkArray[count];
        } else {
            return "";
        }

    }
}
}
