package com.ncr.itss.dao;


import com.ncr.itss.entity.User;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface UserDao {

	/**
	 * @param userName
	 * @return
	 */
	public User getByUserName(String userName);
	
	/**
	 * @param userName
	 * @return
	 */
	public Set<String> getRoles(String userName);
	
	/**
	 * @param userName
	 * @return
	 */
	public Set<String> getPermissions(String userName);
}
