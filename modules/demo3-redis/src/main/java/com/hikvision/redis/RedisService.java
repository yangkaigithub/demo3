package com.hikvision.redis;

import org.springframework.stereotype.Service;

import java.util.Map;


public interface RedisService {


    public Boolean addField(String key,String field,String value);

    public Boolean modField(String key,String field,String value);

    public Boolean addObjectIfabscent(String key, Map<String,String> fvMap);

    public Boolean addObjectCover(String key, Map<String,String> fvMap);


    public Boolean deleteObject(String key);

    public Boolean deleteField(String key ,String field);

    public String getField(String key,String field);

    public Map getObject(int keyInt);


}
