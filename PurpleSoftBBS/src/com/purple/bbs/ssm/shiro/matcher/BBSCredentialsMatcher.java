package com.purple.bbs.ssm.shiro.matcher;

import java.util.concurrent.atomic.AtomicInteger;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @ClassName: AmsCredentialsMatcher 
 * @Description: 自定义密码验证匹配器
 * @author: PurpleSoft@一禅
 * @date: 2018年4月4日 下午3:10:23
 */
public class BBSCredentialsMatcher extends HashedCredentialsMatcher {

    private Cache<String,AtomicInteger> passwordRetryCache;
    
     
     public BBSCredentialsMatcher(CacheManager cacheManager) {
         passwordRetryCache = cacheManager.getCache("shiro-passwordRetryCache");  
     }
    
     @Override
     public boolean doCredentialsMatch(AuthenticationToken token,AuthenticationInfo info) {
         
         String loginName = (String) token.getPrincipal();
         AtomicInteger retryCount = passwordRetryCache.get(loginName);
         if(retryCount==null){
             retryCount = new AtomicInteger();
             passwordRetryCache.put(loginName, retryCount);
         }
         
         if(retryCount.incrementAndGet()>3){
             throw new ExcessiveAttemptsException();
         }
         
         boolean matchs = super.doCredentialsMatch(token, info);
         
         if(matchs){
             passwordRetryCache.remove(loginName);
         }
         
         return super.doCredentialsMatch(token, info);
     }
 
     public Cache<String, AtomicInteger> getPasswordRetryCache() {
         return passwordRetryCache;
     }
 
     public void setPasswordRetryCache(Cache<String, AtomicInteger> passwordRetryCache) {
         this.passwordRetryCache = passwordRetryCache;
     }
}
