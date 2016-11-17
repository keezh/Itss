package com.ncr.itss.service;



import com.ncr.itss.dao.AdminDao;
import com.ncr.itss.dao.PrivilegeDao;
import com.ncr.itss.entity.Admin;
import com.ncr.itss.entity.Privilege;
import com.ncr.itss.enums.PrivilegeType;
import com.ncr.itss.ui.BaseMenu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by feng-er on 2016/4/5.
 */
@Service
public class BaseMenuService {


    @Autowired
    private AdminDao adminDao;


//    @Autowired
//    private PrivilegeService privilegeService;

    @Autowired
    private PrivilegeDao privilegeDao;


    /**
     * 更具用户获取菜单
     *
     * @param userName userName
     * @return 菜单
     */
    public List<BaseMenu> getMenus(String userName) {
        Admin admin = adminDao.findByUsername(userName);
        List<BaseMenu> baseMenus = new ArrayList<>();

        List<Privilege> menus = findAllByAdminId(admin.getId());

        for (Privilege parent : menus) {
            BaseMenu baseMenu = new BaseMenu(parent.getName(), parent.getCode(), parent.getAction());
            List<BaseMenu> children = new ArrayList<>();
            for (Privilege menu : parent.getChildren()) {
                children.add(new BaseMenu(menu.getName(), menu.getCode(), menu.getAction()));
            }
            baseMenu.setChildren(children);
            baseMenus.add(baseMenu);
        }

        return baseMenus;

    }

    /**
     * 获取用户菜单树
     *
     * @param adminId
     * @return
     */
    public List<Privilege> findAllByAdminId(Long adminId) {
        List<Privilege> parents = privilegeDao.findParentsByAdminIdAndType(adminId, PrivilegeType.MENU.getCode());

        if (parents == null) {
            return new ArrayList<>();
        }

        for (Privilege parent : parents) {
            List<Privilege> children = findChildren(parent.getId(), adminId);
            parent.setChildren(children);
        }

        return parents;
    }

    /**
     * 获取子菜单
     *
     * @param parentId
     * @param adminId
     * @return
     */
    public List<Privilege> findChildren(Long parentId, Long adminId) {

        List<Privilege> menus = privilegeDao.findByParentIdAndAdminIdAndType(parentId, adminId, PrivilegeType.MENU.getCode());
        for (Privilege menu : menus) {
            List<Privilege> children = findChildren(menu.getId(), adminId);
            menu.setChildren(children);
        }

        return menus;
    }




}
