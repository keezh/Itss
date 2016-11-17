package com.ncr.itss.controller;


import com.ncr.itss.dao.RoleDao;
import com.ncr.itss.entity.Admin;
import com.ncr.itss.entity.Role;
import com.ncr.itss.entity.User;
import com.ncr.itss.service.AdminService;
import com.ncr.itss.ui.ResponseData;
import com.ncr.itss.ui.Table;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author kee
 */
@Controller
@RequestMapping("admin")
class AdminController {

    private static Logger log = LoggerFactory.getLogger(AdminController.class);


    @Autowired
    private AdminService adminService;

//    @Autowired
//    private AdminDao adminDao;

    @Autowired
    private RoleDao roleDao;


    @RequestMapping("/login")
    public String login(String username,String password, HttpServletRequest request){
        Subject subject= SecurityUtils.getSubject();
        UsernamePasswordToken token=new UsernamePasswordToken(username, password);
        try{
            subject.login(token);
//            Session session=subject.getSession();
//            System.out.println("sessionId:"+session.getId());
//            System.out.println("sessionHost:"+session.getHost());
//            System.out.println("sessionTimeout:"+session.getTimeout());
//            session.setAttribute("info", "session");
            //登录成功,跳转到admin/list.jsp 页面
            return "redirect:list";
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("user", username);
            request.setAttribute("errorMsg", "登录失败");
            return "redirect:/login";
        }
    }




    /**
     * 管 员列
     *
     * @param model .
     * @param page  页
     * @param size  .
     * @param sort  序
     * @return 页
     */
    @RequiresRoles("admin")
    @RequestMapping("list")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       @RequestParam(value = "size", defaultValue = "10") int size,
                       @RequestParam(value = "sort", defaultValue = "id") String sort) {

        List<Admin> admins = adminService.findAll();
        model.addAttribute("admins", admins);
        return "admin/list";
    }


    /**
     * 管 员列
     *
     * @param model  .
     * @param start  开始节
     * @param length .
     * @return 页
     */
    @ResponseBody
    @RequestMapping("list-data")
    public Table listData(Model model, HttpServletRequest request,
                          @RequestParam(value = "start", defaultValue = "0") int start,
                          @RequestParam(value = "length", defaultValue = "length") int length) {
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String s = parameterNames.nextElement();
        }
        List<Admin> admins = adminService.findAll();
        model.addAttribute("admins", admins);
        return new Table(admins.size(), admins.size(), admins);
    }


    /**
     * 加管 员
     *
     * @return .
     */
    @RequestMapping("add")
    public String add(Model model) {
        Admin admin = new Admin();
        List<Role> roles = roleDao.findAll();
        model.addAttribute("roles", roles);
        model.addAttribute("admin", admin);
        return "admin/edit";
    }

    /**
     * 编 管 员
     *
     * @return .
     */
    @RequestMapping("edit")
    public String edit(Model model, Long id) {
        Admin admin = adminService.find(id);
        List<Role> roles = roleDao.findAll();
        model.addAttribute("roles", roles);
        List<Role> adminRoles = roleDao.findByAdminId(admin.getId());

        Map<String, Boolean> adminRoleMap = new HashMap<>();

        for (Role role : adminRoles) {
            adminRoleMap.put(role.getCode(), true);
        }

        model.addAttribute("bean", admin);
        model.addAttribute("adminRoleMap", adminRoleMap);
        return "admin/edit";
    }


    /**
     * 保存管 员
     *
     * @return .
     */
    @ResponseBody
    @RequestMapping("save")
    public ResponseData save(Admin admin, Long[] role) {
        ResponseData responseData = new ResponseData();

        Boolean result = adminService.save(admin, role);

        if (result) {
            responseData.setCode(true);
            responseData.setData("保存成功");
        } else {
            responseData.setCode(false);
            responseData.setData("保存失败");
        }

        return responseData;
    }

    /**
     * 置密
     *
     * @param id .
     * @return .
     */
    @ResponseBody
    @RequestMapping("reset-password")
    public ResponseData resetPassword(Long id) {
        ResponseData responseData = new ResponseData(true, "密码已重置为【1234】!");

        String newPassword = "1234";
        Admin admin = adminService.find(id);
        admin.setPassword(newPassword);
        adminService.update(admin);

        return responseData;
    }

}
