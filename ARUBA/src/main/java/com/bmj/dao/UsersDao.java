package com.bmj.dao;

import com.bmj.entity.Users;

public interface UsersDao {
	Integer getUsersCount();
	int insertUser(Users user);
	int updateUser(Users user);
	int deleteUser(Users user);
	int updatePassUser(Users user);
	Users loginUser(Users user);
	int countByUserId(String userId);
	Users selectUserByUserId(String userId);
	Users selectUserByBirthAndEmail(Users user);
}
