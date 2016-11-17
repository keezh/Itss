package com.ncr.itss.controller;


import com.ncr.itss.core.utils.StringUtils;
import com.ncr.itss.dao.PrivilegeDao;
import com.ncr.itss.dao.RoleDao;
import com.ncr.itss.entity.Privilege;
import com.ncr.itss.entity.Role;
import com.ncr.itss.enums.PrivilegeType;
import com.ncr.itss.service.PrivilegeService;
import com.ncr.itss.service.RoleService;
import com.ncr.itss.ui.ResponseData;
import com.ncr.itss.ui.Table;
import com.ncr.itss.ui.Tree;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by renshilei on 2015/9/7.
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    private static final Logger logger = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    private RoleDao roleDao;


    @Autowired
    private PrivilegeService menuService;

    @Autowired
    private PrivilegeDao privilegeDao;


    @Autowired
    private RoleService roleService;

    @Autowired
    private PrivilegeService privilegeService;

    /**
     * 角色列表
     *
     * @return
     */
    @RequestMapping("list")
    public String list(Model model) {
        List<Role> roleList = roleDao.findAll();
        model.addAttribute("roleList", roleList);
        return "role/list";
    }


    /**
     * @return
     */
    @ResponseBody
    @RequestMapping("list-data")
    public Table listData(
            @RequestParam(value = "start", defaultValue = "0") Integer start,
            @RequestParam(value = "length", defaultValue = "10") Integer length) {
        List<Role> roleList = roleDao.findAll();
        return new Table(roleList.size(), roleList.size(), roleList);
    }

    /**
     * 形
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/privilege/tree-data")
    public List<Tree> treeData(String id, Long roleId) {
        List<Privilege> privilegeList;
        if (StringUtils.isEmpty(id) || StringUtils.equals("#", id)) {
            privilegeList = privilegeService.findAll();
            List<Tree> treeList = getTrees(privilegeList, roleId);
            Tree root = new Tree();
            root.setId("#");
            root.setName("菜单管理");
            root.setIsParent(true);
            root.setIconSkin("root");
            root.setType(PrivilegeType.MENU.getCode());
            root.setChildren(treeList);
            List<Tree> rootList = new ArrayList<>();
            rootList.add(root);
            return rootList;
        } else {
            privilegeList = privilegeService.findChildren(Long.parseLong(id));
            return getTrees(privilegeList, roleId);
        }
    }

    /**
     * 角色的权限展示   （List<Privilege>=>List<Tree>）
     *
     * @param privilegeList
     * @return
     */
    private List<Tree> getTrees(List<Privilege> privilegeList, Long roleId) {
        List<Tree> treeList = new ArrayList<>();
        Set<String> privilegeSet = privilegeDao.findCodeByRoleId(roleId);

        for (Privilege privilege : privilegeList) {
            Tree tree = new Tree();
            tree.setId(privilege.getId() + "");
            tree.setName(privilege.getName());

            if (privilege.getType().equals(PrivilegeType.BUTTON.getCode())) {
                tree.setIsParent(false);
            } else {
                tree.setIsParent(true);
            }
            if (privilegeSet.contains(privilege.getCode())) {
                tree.setChecked(true);
            } else {
                tree.setChecked(false);
            }

            tree.setIconSkin(PrivilegeType.getIconSkin(privilege.getType()));
            tree.setType(privilege.getType());
            treeList.add(tree);
        }
        return treeList;
    }


    /**
     * 添加角色
     *
     * @param model
     * @return
     */
    @RequestMapping("add")
    public String add(Model model) {
        Role role;
        role = new Role();

        model.addAttribute("bean", role);

        List<Privilege> menuList = menuService.findAll();


        Map<String, Boolean> roleMenuMap = new HashMap<>();
        Map<Object, String> typeMap = new HashMap<>();
        typeMap.put(PrivilegeType.MENU.getCode(), PrivilegeType.MENU.getMessage());
        typeMap.put(PrivilegeType.BUTTON.getCode(), PrivilegeType.BUTTON.getMessage());

        model.addAttribute("typeMap", typeMap);
//
        model.addAttribute("menuList", menuList);
        model.addAttribute("roleMenuMap", roleMenuMap);
        model.addAttribute("typeMap", typeMap);

        return "role/edit";
    }

    /**
     * 编辑角色
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("edit")
    public String edit(Long id, Model model) {
        Role role;
        if (id == null) {
            role = new Role();
        } else {
            role = roleDao.find(id);
        }
        model.addAttribute("bean", role);

        List<Privilege> menus = privilegeDao.findByRoleId(id);

        Map<String, Boolean> roleMenuMap = new HashMap<>();

        for (Privilege menu : menus) {
            roleMenuMap.put(menu.getCode(), true);
        }

        Map<Object, String> typeMap = new HashMap<>();
        typeMap.put(PrivilegeType.MENU.getCode(), PrivilegeType.MENU.getMessage());
        typeMap.put(PrivilegeType.BUTTON.getCode(), PrivilegeType.BUTTON.getMessage());

        List<Privilege> menuList = menuService.findAll();

        model.addAttribute("menuList", menuList);
        model.addAttribute("roleMenuMap", roleMenuMap);
        model.addAttribute("typeMap", typeMap);

        return "role/edit";
    }

    /**
     * 保存角色
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("save")
    public ResponseData save(Role role, @RequestParam(value = "privilege", required = false) String[] privileges) {
        roleService.save(role, privileges);
        return new ResponseData(true, "成功");
    }


    /**
     * 删除角色
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("delete")
    public ResponseData delete(Long id) {
        roleService.delete(id);
        return new ResponseData(true, "成功");
    }

}
