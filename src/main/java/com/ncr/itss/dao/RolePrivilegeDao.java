package com.ncr.itss.dao;


import com.ncr.itss.base.BaseMapper;
import com.ncr.itss.entity.RolePrivilege;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Component
public interface RolePrivilegeDao extends BaseMapper<RolePrivilege> {

    int deleteByRoleId(@Param("roleId") Long roleId);

    int deleteByPrivilegeId(@Param("privilegeId") Long privilegeId);

}
