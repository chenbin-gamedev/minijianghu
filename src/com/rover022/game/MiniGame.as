package com.rover022.game {
import com.rover022.game.scenes.GameScene;
import com.rover022.game.scenes.PixelScene;
import com.rover022.game.scenes.Scene;

import flash.geom.Point;

import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import starling.events.Event;
import starling.utils.AssetManager;

/**
 * 实现了GAME中的很多方法
 * 切换内容场景;
 * 方法1 :switchScene
 *
 */
public class MiniGame extends PixelScene {
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
    public static var assets:AssetManager;


    public function MiniGame() {
        instance = this;
    }

    override public function onBackPressed(e:Event = null):void {
//        var game:GameScene = new GameScene();
        switchScene(GameScene)
    }

    override public function create():void {
        super.create();
        instance = this;
        trace("MiniGame engine is create");
        //onSurfaceCreated();
    }

    public function resize():void {

    }

    public function destroyGame():void {

    }

    public static function resetScene():void {
        var className:String = getQualifiedClassName(instance);
        var _class:Class = getDefinitionByName(className) as Class;
        switchScene(_class);
    }

    public static function switchScene(c:Class, callBack:Function = null):void {
        instance.sceneClass = c;
        instance.requestedReset = true;
        instance.onChange = callBack;
        if (instance.scene) {
            instance.scene.removeFromParent();
            instance.scene.destroy();
        }
        instance.scene = new c();
        instance.addChild(instance.scene);
        instance.scene.create();
        if (callBack) {
            callBack.call(null);
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

    public static function distance(pos:Point, pos2:Point):int {
        return 0;
    }

    public function start(_assets:AssetManager):void {
        assets = _assets;
        beforeCreate();
        create();
        afterCreate();
    }

    public function finish():void {

    }
}
}
