package com.chengyu.cy_2d_amap_base;

import android.app.Application;


/**
 * BmfMapApplicationt有两种使用方式：
 * 1、直接继承与BmfMapApplication
 * 2、将onCreate里的初始化逻辑拷到业务工程Application的onCreate函数里
 */
public class CYMapApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        CYContextHelper.sContext = this;
//        SDKInitializer.initialize(this);
    }
}
