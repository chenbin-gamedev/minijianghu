package com.rover022.game {
import com.rover022.game.scenes.Scene;

import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class MiniGame extends Scene {
    public static var instance:MiniGame;
    public static var width:Number;
    public static var height:Number;
    //
    public static var version:String = "1.0.1";
    //当前游戏场景
    public var scene:Scene;
    public var sceneClass:Class;
    public var requestedReset:Boolean;
    public var onChange:Function;

    public function MiniGame() {

    }

    public function create():void {

    }

    public function resume():void {

    }

    public function pause():void {

    }

    public function resize():void {

    }

    public function destroyGame():void {

    }


    public static function resetScene() {
        var className:String = getQualifiedClassName(instance);
        var _class:Class = getDefinitionByName(className) as Class;
        switchScene(_class);
    }

    public static function switchScene(c:Class, callBack:Function = null):void {
        if (c is Scene) {
            instance.sceneClass = c;
            instance.requestedReset = true;
            instance.onChange = callBack;
        } else {
            trace("要切换的类不符合");
        }
    }

    public static function get scene():Scene {
        return instance.scene;
    }


    override public function update():void {
        scene.update();
    }

    public function sceneChangeCallBack():void {
        beforeCreate();
        afterCreate();
    }

    public function afterCreate():void {

    }

    public function beforeCreate():void {

    }

    public static function distance(pos:int, pos2:int):int {

    }
}
}
