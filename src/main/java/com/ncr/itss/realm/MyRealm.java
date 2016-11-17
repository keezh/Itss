package com.ncr.itss.realm;

import com.ncr.itss.dao.AdminDao;
import com.ncr.itss.dao.PrivilegeDao;
import com.ncr.itss.entity.Admin;
import com.ncr.itss.entity.User;
import com.ncr.itss.service.BaseMenuService;
import com.ncr.itss.service.UserService;
import com.ncr.itss.ui.BaseMenu;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Component
public class MyRealm extends AuthorizingRealm {

//	@Autowired
//	private UserService userService;

	@Autowired
	private BaseMenuService baseMenuService;

	@Autowired
	private PrivilegeDao privilegeDao;

	@Autowired
	private AdminDao adminDao;
	
	/**
	 *  这个函数,登录成功后,怎么被回调了两次???
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String userName=(String)principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo authorizationInfo=new SimpleAuthorizationInfo();
		//登录验证成功后获取用户角色和权限
		//封装菜单
		List<BaseMenu> menus = baseMenuService.getMenus(userName);

		Admin admin = adminDao.findByUsername(userName);

		Subject currentUser = SecurityUtils.getSubject();
		Session shiroSession = currentUser.getSession();
		shiroSession.setAttribute("menus",menus);
		shiroSession.setAttribute("test","kee");

//		request.getSession().setAttribute("menus", menus);

		//添加权限
		Set<String> privileges = privilegeDao.findCodeByAdminId(admin.getId());
		shiroSession.setAttribute("privileges", privileges);

//		request.getSession().setAttribute("privileges", privileges);
//		authorizationInfo.setRoles(userService.getRoles(userName));
//		authorizationInfo.setStringPermissions(userService.getPermissions(userName));
		return authorizationInfo;
	}

	/**
	 *
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String userName=(String)token.getPrincipal();
			Admin admin=adminDao.findByUsername(userName);
			if(admin!=null){
				getMenus(userName);//手动设置到session中
				AuthenticationInfo authcInfo=new SimpleAuthenticationInfo(admin.getUsername(),admin.getPassword(),"xx");
				return authcInfo;
			}else{
				return null;				
			}
	}

	private void getMenus(String userName){
		List<BaseMenu> menus = baseMenuService.getMenus(userName);

		Admin admin = adminDao.findByUsername(userName);

		Subject currentUser = SecurityUtils.getSubject();
		Session shiroSession = currentUser.getSession();
		shiroSession.setAttribute("menus",menus);
		shiroSession.setAttribute("test","kee");

//		request.getSession().setAttribute("menus", menus);

		//添加权限
		Set<String> privileges = privilegeDao.findCodeByAdminId(admin.getId());
		shiroSession.setAttribute("privileges", privileges);

	}

}
