package com.rover022.game.scenes {
import com.rover022.game.MiniGame;

import flash.geom.Rectangle;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;

import utils.MenuButton;

public class Scene extends Sprite {
    private var _backButton:Button;

    public function Scene() {
        // the main menu listens for TRIGGERED events, so we just need to add the button.
        // (the event will bubble up when it's dispatched.)
    }

    public function update():void {

    }

    public function create():void {

    }

    public function initTest():void {
        _backButton = new MenuButton("Back", 88, 50);
        _backButton.x = Constants.CenterX - _backButton.width / 2;
        _backButton.y = Constants.GameHeight - _backButton.height + 12;
        _backButton.name = "backButton";
        _backButton.textBounds.y -= 3;
        _backButton.readjustSize(); // forces textBounds to update
        _backButton.addEventListener(Event.TRIGGERED, onBackPressed);
        addChild(_backButton);
    }

    public function destroy():void {

    }

    public function pause():void {

    }

    public function resume():void {

    }

    public function onBackPressed(e:Event = null):void {
        MiniGame.instance.finish();
    }

    public function onMenuPressed(e:Event = null):void {

    }

}
}