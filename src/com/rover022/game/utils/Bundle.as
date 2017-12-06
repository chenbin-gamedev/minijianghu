package com.rover022.game.utils {
import avmplus.getQualifiedClassName;

import com.rover022.game.Dungeon;
import com.rover022.game.actors.hero.Hero;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.getDefinitionByName;

public class Bundle {

    public var data:Object = {};
    private static var CLASS_NAME:String = "__className";

    public function Bundle(src:Object = null) {
        if (src) {
            data = src;
        } else {
            data = {};
        }
    }

    public function put(key:String, value:Object):void {
        if (value is Bundlable) {
            putBundlable(key, value as Bundlable);
        } else {
            data[key] = value;
        }
    }

    public function putBundlable(key:String, value:Bundlable):void {
        var object:Bundlable = value as Bundlable;
        var bundle:Bundle = new Bundle();
        object.storeInBundle(bundle);
        data[CLASS_NAME] = getQualifiedClassName(value);
        data[key] = bundle.data;

    }

    public function toString():String {
        return JSON.stringify(data);
    }

    public function getHero():Hero {
        return Dungeon.hero;
    }

    public function getDroppedItems():Array {
        return new Array()
    }

    /**
     * 读取数据
     * @param fileName
     * @return
     */
    public static function read(fileName:String):Bundle {
        try {
            var file:File = File.applicationStorageDirectory.resolvePath(fileName);
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.READ);
            var dataString:String = stream.readUTF();
            stream.close();
            trace("读文件成功", dataString);
        } catch (e:Error) {
            trace("读文件出错了", e);
            return null;
        }
        var data:Object = JSON.parse(dataString);
        return new Bundle(data);
    }

    public static function write(bundel:Bundle, fileName:String):Boolean {
        var dataString:String = bundel.toString();
        trace("Bundle data :", dataString);
        var file:File = File.applicationStorageDirectory.resolvePath(fileName);
        var stream:FileStream = new FileStream();
        stream.open(file, FileMode.WRITE);
        stream.writeUTF(dataString);
        stream.close();
        trace("保存文件成功");
        return true;
        try {
            var dataString:String = bundel.toString();
            trace("Bundle data :", dataString);
            var file:File = File.applicationStorageDirectory.resolvePath(fileName);
            var stream:FileStream = new FileStream();
            stream.open(file, FileMode.WRITE);
            stream.writeUTF(dataString);
            stream.close();
            trace("保存文件成功");
        } catch (e:Error) {
            trace("写文件出错了", e);
            return false;
        }
        return true;
    }

    public function getClassObject():Bundlable {
        return null;
    }

    public function getBundle(key:String):Bundle {
        return new Bundle(data.key);
    }

    public function getBundleList(key:String):Array {
        var array:Array = data.key;
        if (array == null) {
            return array;
        }
        var finArray:Array = [];
        for (var i:int = 0; i < array.length; i++) {
            var bb:Bundle = new Bundle(array[i]);
            var bundle:Bundlable = bb.getObject();
            finArray.push(bundle);
        }
        return finArray;

    }

    public function getNumber(key:String):Number {
        return data.key;
    }

    public function getInt(key:String):int {
        return data.key;
    }

    public function getString(key:String):String {
        return data.key;
    }

    public function getValue(key:String):Object {
        return data.key;
    }

    /**
     * 实现类的反射
     * @return
     */
    public function getObject():Bundlable {
        if (data == null) {
            return null;
        }
        var className:String = getString(CLASS_NAME);
        var _class:Class = getDefinitionByName(className) as Class;
        var obj:Bundlable = new _class();
        obj.restoreFromBundle(this);
        return obj
    }

    public function putBundleList(_key:String, bundles:Array):void {
        if (bundles == null) {
            data[_key] = bundles;
            return;
        }
        var _arr:Array = [];
        for (var i:int = 0; i < bundles.length; i++) {
            var newbundle:Bundle = new Bundle();
            var object:Bundlable = bundles[i];
            object.storeInBundle(newbundle);
            _arr.push(newbundle);
        }
        data[_key] = _arr;
    }
}
}
