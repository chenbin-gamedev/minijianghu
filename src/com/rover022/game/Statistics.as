package com.rover022.game {
/**
 * 全部统计系统
 * 成绩系统
 */
public class Statistics {
    public static var deepesFloor:int;
    public static var goldCollected:int;
    public static var depestFloor:int;
    public static var enemiessSlain:int;
    public static var foodEaten:int;
    public static var potionsCooked:int;
    public static var piranhasKilled:int;
    public static var ankhsUsed:int;
    public function Statistics() {
    }




    public static function reset():void {
        goldCollected = 0;
        depestFloor = 0;
        enemiessSlain = 0;
        foodEaten = 0;
        potionsCooked = 0;
        piranhasKilled = 0;
        ankhsUsed = 0;
    }
}
}
