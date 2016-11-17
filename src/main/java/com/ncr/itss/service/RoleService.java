package com.ncr.itss.service;


import com.ncr.itss.dao.PrivilegeDao;
import com.ncr.itss.dao.RoleDao;
import com.ncr.itss.dao.RolePrivilegeDao;
import com.ncr.itss.entity.Privilege;
import com.ncr.itss.entity.Role;
import com.ncr.itss.entity.RolePrivilege;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * Created by feng- on 2016/4/5.
 */
@Service
public class RoleService {
    @Autowired
    private RoleDao roleDao;

    @Autowired
    private RolePrivilegeDao rolePrivilegeDao;

    @Autowired
    private PrivilegeDao privilegeDao;


    /**
     * 色保存 刷
     *
     * @param role
     * @param privilege
     */
    public void save(Role role, String[] privilege) {
        Role target;
        if (null == role.getId()) {
            target = role;
            roleDao.insert(target);
        } else {
            target = roleDao.find(role.getId());
            target.setCode(role.getCode());
            target.setName(role.getName());
            rolePrivilegeDao.deleteByRoleId(role.getId());

        }

        if (privilege != null) {
            for (String privilegeId : privilege) {
                RolePrivilege rolePrivilege = new RolePrivilege();
                Privilege p = new Privilege();
                p.setId(Long.parseLong(privilegeId));
                rolePrivilege.setPrivilege(p);
                rolePrivilege.setRole(role);

                rolePrivilegeDao.insert(rolePrivilege);
            }

        }

    }

    public void delete(Long id) {
        rolePrivilegeDao.deleteByPrivilegeId(id);
        roleDao.deleteAdminRoleByRoleId(id);
        roleDao.delete(id);
    }
}
