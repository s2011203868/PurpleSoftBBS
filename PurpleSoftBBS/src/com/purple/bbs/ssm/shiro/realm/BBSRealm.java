package com.purple.bbs.ssm.shiro.realm;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.purple.bbs.ssm.mapper.SysUserMapper;
import com.purple.bbs.ssm.pojo.SysUser;
import com.purple.bbs.ssm.service.SysUserService;

/**
 * 
 * @ClassName: AMSRealm 
 * @Description: TODO
 * @author: PurpleSoft@一禅
 * @date: 2018年4月3日 上午9:52:30
 */
public class BBSRealm extends AuthorizingRealm {

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserMapper sysUsermapper;
	
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		
		
		//先从Token中获取email
	    String email = (String) token.getPrincipal();
	    
	    SysUser sysUser = null;
		String password = "";
		String salt = "";
		try {
			sysUser= sysUserService.findUserByEmail(email);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(sysUser == null){
			return null;
		}else if(sysUser.getStatus() ==2){
			throw new DisabledAccountException();
		}else if(!"管理员".equals(sysUser.getAuthentication()) && sysUser.getKiss() >=2000 && sysUser.getKiss() <3000  && !"社区智尊".equals(sysUser.getAuthentication())){
		    try {
		        sysUserService.setAuthentication("社区智尊","VIP1",email);
                sysUser= sysUserService.findUserByEmail(email);
            } catch (Exception e) {
                e.printStackTrace();
            }
		}else if(!"管理员".equals(sysUser.getAuthentication()) &&"社区智尊".equals(sysUser.getAuthentication()) && sysUser.getKiss() >=3000 && sysUser.getKiss()<4000){
		    try {
                sysUserService.setAuthentication("社区智尊","VIP2",email);
                sysUser= sysUserService.findUserByEmail(email);
            } catch (Exception e) {
                e.printStackTrace();
            }
           
        }else if(!"管理员".equals(sysUser.getAuthentication()) &&"社区智尊".equals(sysUser.getAuthentication()) && sysUser.getKiss() >=4000){
            try {
                sysUserService.setAuthentication("社区智尊","VIP3",email);
                sysUser= sysUserService.findUserByEmail(email);
            } catch (Exception e) {
                e.printStackTrace();
            }
           
        }
		
		
		password = sysUser.getPassword();
        salt = sysUser.getSalt();
		//查询到返回认证信息SimpleAuthenticationInfo
	    SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(sysUser, password,ByteSource.Util.bytes(salt), this.getName());
	    
	    return simpleAuthenticationInfo;
	}
	
	
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection token) {
		
		/*ActiveUser activeUser = (ActiveUser) token.getPrimaryPrincipal();
		List<String> permissions = new ArrayList<String>();
		try {
			List<SysPermission> hasSysPermissions = sysUserService.findPermissionsByUser(activeUser.getUserid());
			if(hasSysPermissions !=null){
				for(SysPermission sysPermission : hasSysPermissions){
					if(sysPermission.getPerCode()!=null && sysPermission.getPerCode() != ""){
						permissions.add(sysPermission.getPerCode());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		
		//SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		//simpleAuthorizationInfo.addStringPermissions(permissions);
		return null;
	}

    /** 
     * 清理权限缓存 
     */  
    public void clearCachedAuthorization(){  
        //清空权限缓存  
        super.clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());  
    }  
}
