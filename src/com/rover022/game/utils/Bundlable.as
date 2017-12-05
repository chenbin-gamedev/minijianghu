package com.rover022.game.utils {

/**
 * 一个接口 可以从json读取数据生成对象的类接口
 * 所有实现这个类都可以转化为数据保存到磁盘上
 */
public interface Bundlable {

    /**
     * 快速读取
     * @param bundle
     */
    function restoreFromBindle(bundle:Bundle):void;

    /**
     * 快速保存
     * @param bundle
     */
    function storeInBundle(bundle:Bundle):void;
}
}
