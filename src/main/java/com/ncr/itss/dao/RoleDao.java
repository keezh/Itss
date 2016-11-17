package com.ncr.itss.dao;


import com.ncr.itss.base.BaseMapper;
import com.ncr.itss.entity.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface RoleDao extends BaseMapper<Role> {

    List<Role> findByMenuId(@Param("menuId") Long menuId);

    List<Role> findByAdminId(@Param("adminId") Long adminId);

    Integer insertAdminRole(
            @Param("adminId") Long adminId,
            @Param("roleId") Long roleId);

    Integer deleteAdminRoleByAdminId(@Param("adminId") Long adminId);

    Integer deleteAdminRoleByRoleId(@Param("roleId") Long roleId);

}
