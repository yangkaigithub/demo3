package com.hikvision.redis;

import com.hikvision.redis.util.CommodityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;


@Service
public class RedisServiceImpl implements RedisService{
    @Autowired
    protected RedisTemplate redisTemplate;

    @Resource(name = "redisTemplate")
    protected HashOperations<String,String,String> hashOperations;

    @Autowired(required = false)
    public void setRedisTemplate(RedisTemplate redisTemplate) {
        RedisSerializer stringSerializer = new StringRedisSerializer();
        redisTemplate.setKeySerializer(stringSerializer);
        redisTemplate.setValueSerializer(stringSerializer);
        redisTemplate.setHashKeySerializer(stringSerializer);
        redisTemplate.setHashValueSerializer(stringSerializer);
        this.redisTemplate = redisTemplate;
    }


    public Boolean addField(String key,String field,String value){
        if(hashOperations.putIfAbsent(key,field,value)){
            System.out.println("添加字段成功");
            return true;
        }else{
            System.out.println("添加字段失败，字段重复");
            return false;
        }
    }

    public Boolean modField(String key,String field,String value){
        if(hashOperations.hasKey(key,field)){
            hashOperations.put(key,field,value);
            System.out.println("修改字段成功");
            return true;
        }else{
            System.out.println("修改字段失败，不存在此字段");
            return false;
        }
    }


    @Override
    public Boolean addObjectIfabscent(String key, Map<String,String> fvMap){
        if(redisTemplate.hasKey(key)){
            System.out.println(key+"由于重复，添加失败");
            return false;
        }else{
            hashOperations.putAll(key,fvMap);
            System.out.println(key+"已添加");
            return true;

        }
    }

    @Override
    public Boolean addObjectCover(String key, Map<String,String> fvMap){
        if(redisTemplate.hasKey(key)){
            redisTemplate.delete(key);
            hashOperations.putAll(key,fvMap);
        }else{
            hashOperations.putAll(key,fvMap);
        }
        return true;
    }


    public Boolean deleteObject(String key){
        if(redisTemplate.hasKey(key)) {
            redisTemplate.delete(key);
            return true;
        }else{
            return false;
        }
    }

    public Boolean deleteField(String key ,String field){
        if(hashOperations.hasKey(key,field)){
            hashOperations.delete(key,field);
            return true;
        }else{
            return false;
        }
    }
    public String getField(String key,String field ){
        if(hashOperations.hasKey(key,field)){
            return hashOperations.get(key,field);
        }else{
            return "no";
        }
    }

    @Override
    public Map getObject(int keyInt) {
        String key = CommodityUtil.valueTokey(keyInt);
        if(redisTemplate.hasKey(key)) {
           return hashOperations.entries(key);
        }else{
            return null;
        }
    }

}
