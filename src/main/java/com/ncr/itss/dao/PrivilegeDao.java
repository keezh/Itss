package com.ncr.itss.dao;


import com.ncr.itss.base.BaseMapper;
import com.ncr.itss.entity.Privilege;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;

@Component
public interface PrivilegeDao extends BaseMapper<Privilege> {

    List<Privilege> findParents();

    List<Privilege> findByParentId(@Param("parentId") Long parentId);

    List<Privilege> findByRoleId(@Param("roleId") Long roleId);

    List<Privilege> findByAdminId(@Param("adminId") Long adminId);

    Set<String> findCodeByAdminId(@Param("adminId") Long adminId);

    Set<String> findCodeByRoleId(@Param("roleId") Long roleId);

    List<Privilege> findParentsByAdminId(@Param("adminId") Long adminId);

    List<Privilege> findByParentIdAndAdminId(@Param("parentId") Long parentId, @Param("adminId") Long adminId);

    List<Privilege> findByParentIdAndAdminIdAndType(@Param("parentId") Long parentId, @Param("adminId") Long adminId, @Param("type") Integer type);

    Integer deleteByParentId(@Param("parentId") Long parentId);

    List<Privilege> findParentsByAdminIdAndType(@Param("adminId") Long adminId, @Param("type") Integer type);
}
