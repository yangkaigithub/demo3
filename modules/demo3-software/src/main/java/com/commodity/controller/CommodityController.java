package com.commodity.controller;


import com.hikvision.redis.RedisService;
import com.hikvision.redis.util.CommodityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
public class CommodityController {


    @Autowired
    RedisService redisService;

    private static String key_pre = "commodity:";

    @RequestMapping("/init")
    @ResponseBody
    public String init() {
        for (int j = 0; j < 500000; j++) {
            Map<String,String> commodityMap = new LinkedHashMap<>();
            for (int i = 0; i < 10; i++) {
                commodityMap.put("field" + i, "defult value");
            }
            String key = CommodityUtil.valueTokey(j);
            redisService.addObjectIfabscent(key, commodityMap);
        }
        return "success";

    }

    @RequestMapping("/getAField")
    @ResponseBody
    public String getAField(String key,String field) {
        return redisService.getField(key,"field0");
    }
}