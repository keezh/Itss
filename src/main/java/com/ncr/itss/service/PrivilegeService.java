package com.ncr.itss.service;




import com.ncr.itss.dao.PrivilegeDao;
import com.ncr.itss.dao.RolePrivilegeDao;
import com.ncr.itss.entity.Privilege;
import com.ncr.itss.enums.PrivilegeType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by feng-er on 2016/4/5.
 */
@Service
public class PrivilegeService {


    @Autowired
    private PrivilegeDao privilegeDao;


    @Autowired
    private RolePrivilegeDao rolePrivilegeDao;


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
     * 获取全部菜单树
     *
     * @return
     */
    public List<Privilege> findAll() {
        List<Privilege> parents = privilegeDao.findParents();
        for (Privilege parent : parents) {
            List<Privilege> children = findChildren(parent.getId());
            parent.setChildren(children);
        }
        return parents;
    }

    /**
     * 获取子菜单
     *
     * @param parentId
     * @return
     */
    public List<Privilege> findChildren(Long parentId) {

        List<Privilege> menus = privilegeDao.findByParentId(parentId);
        for (Privilege menu : menus) {
            List<Privilege> children = findChildren(menu.getId());
            menu.setChildren(children);
        }

        return menus;
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

    /**
     * 删除菜单,同时删除关联角色,子菜单
     *
     * @param id
     */
    public Boolean delete(Long id) {
        List<Privilege> menus = privilegeDao.findByParentId(id);


        if (menus.size() > 0) {
            return false;
        }

        int i = rolePrivilegeDao.deleteByPrivilegeId(id);


        for (Privilege menu : menus) {
            rolePrivilegeDao.deleteByPrivilegeId(menu.getId());//// TODO: 9/23/16 删除算法需要优化
        }

        privilegeDao.deleteByParentId(id);

        privilegeDao.delete(id);
        return true;
    }


}
