package com.commodity.controller;

import com.hikvision.redis.RedisService;
import com.hikvision.redis.util.CommodityUtil;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class MainController {
    @Autowired
    RedisService redisService;

    @RequestMapping("/hello")
    @ResponseBody
    public String home() {
        return "hello";
    }

    @RequestMapping("/")
    public String index(LinkedHashMap<String,Object> map){
        Map<String,Map<String,String>> commodityMap = new LinkedHashMap<>();
        for (int i = 0; i < 15; i++) {
            List<Map.Entry<String, String>> infoIds = new ArrayList<>(redisService.getObject(i).entrySet());
            Collections.sort(infoIds, new Comparator<Map.Entry<String, String>>() {
                @Override
                public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
                    if(o1.getKey().contains("field")&&o2.getKey().contains("field")){
                        int a1 = Integer.parseInt(o1.getKey().substring(5,o1.getKey().length()));
                        int a2 = Integer.parseInt(o2.getKey().substring(5,o2.getKey().length()));
                        if(a1 - a2<0){
                            return -1;
                        }else{
                            return 1;
                        }
                    }else{
                        return 1;
                    }
                }
            });

            Map<String,String> fieldMap = new LinkedHashMap<>();
            for (int j = 0; j < infoIds.size(); j++) {
                fieldMap.put(infoIds.get(j).getKey(),infoIds.get(j).getValue());
            }
            commodityMap.put(CommodityUtil.valueTokey(i),fieldMap);
        }
        map.put("commodityMap",commodityMap);
        map.put("pageNum",1);
        return "index";
    }

    @RequestMapping("/nextpage")
    public String nextpage(LinkedHashMap<String,Object> map,int pageNum){
        pageNum=pageNum<0?0:pageNum;
        Map<String,Map<String,String>> commodityMap = new LinkedHashMap<>();
        while(redisService.getObject((pageNum-1)*15)==null){
            pageNum = pageNum - 1;
        }
        for (int i = (pageNum-1)*15; i < 15*pageNum; i++) {
            commodityMap.put(CommodityUtil.valueTokey(i),redisService.getObject(i));
        }
        map.put("commodityMap",commodityMap);
        map.put("pageNum",pageNum);
        return "index";
    }


    @RequestMapping("/topage")
    public String topage(LinkedHashMap<String,Object> map,int pageNum){
        return "redirect:/nextpage?pageNum="+pageNum;
    }

}
