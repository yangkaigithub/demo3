package com.hikvision.redis.util;

public  class CommodityUtil {
    private static String key_pre = "commodity:";
    public static String valueTokey(int value){
        String key = String.valueOf(value);
        while(key.length()<6){
            key = "0" + key;
        }
        key = key_pre + key;
        return key;
    }
}
