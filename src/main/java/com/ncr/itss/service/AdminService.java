package com.ncr.itss.service;

import com.ncr.itss.core.utils.StringUtils;
import com.ncr.itss.dao.AdminDao;
import com.ncr.itss.dao.RoleDao;
import com.ncr.itss.entity.Admin;
import com.ncr.itss.entity.AdminRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;


/**
 * Created by feng-er on 2016/4/5.
 */
@Service
public class AdminService {


    @Autowired
    private AdminDao adminDao;


    @Autowired
    private RoleDao roleDao;

    public List<Admin> findAll(){
        return adminDao.findAll();
    }

    public Admin find(Long id){
        return adminDao.find(id);
    }

    public int update(Admin admin){
       return adminDao.update(admin);
    }





    /**
     * 保存
     *
     * @param admin
     * @param roles
     */
    public Boolean save(Admin admin, Long[] roles) {

        Admin target;

        if (admin.getId() == null) {
            String username = admin.getUsername();
            target = adminDao.findByUsername(username);
            if (target == null) {
                target = admin;

                /*生成密码*/
                if (StringUtils.isNoneEmpty(admin.getPassword())) {
//                    String newPassword = StringUtils.md5Format(admin.getPassword());
                    target.setPassword(admin.getPassword());
                }

                Date createAt = new Date();
                admin.setCreateAt(createAt);
                admin.setUpdateAt(createAt);
                adminDao.insert(target);
                saveAdminRoles(target, roles);
                return true;
            } else {
                return false;
            }
        } else {
            target = adminDao.find(admin.getId());

            admin.setUpdateAt(new Date());
            adminDao.update(target);

            saveAdminRoles(target, roles);


            return true;
        }

    }

    /**
     * 保存   色关系
     *
     * @param admin
     * @param role
     */
    private void saveAdminRoles(Admin admin, Long[] role) {
        roleDao.deleteAdminRoleByAdminId(admin.getId());
        if (role != null) {
            for (Long roleId : role) {
                roleDao.insertAdminRole(admin.getId(), roleId);
                AdminRole adminRole = new AdminRole();
                adminRole.setAdmin(admin);
                adminRole.setRole(roleDao.find(roleId));
            }
        }

    }


}
