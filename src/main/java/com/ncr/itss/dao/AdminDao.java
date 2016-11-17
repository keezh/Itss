package com.ncr.itss.dao;

import com.ncr.itss.base.BaseMapper;
import com.ncr.itss.entity.Admin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Component
public interface AdminDao extends BaseMapper<Admin> {


    Admin findByUsername(@Param("userName") String userName);

}
