package com.ncr.itss.service;


import com.ncr.itss.entity.User;

import java.util.Set;

public interface UserService {

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
