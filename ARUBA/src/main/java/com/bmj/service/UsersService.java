package com.bmj.service;

import java.util.List;

import com.bmj.entity.Users;

public interface UsersService {
	Integer getUsersCount();
	int insertUser(Users user);
	int updateUser(Users user);
	int deleteUser(Users user);
	int updatePassUser(Users user);
	Users loginUser(Users user);
	int countByUserId(String userId);
	Users selectUserByUserId(String userId);
	List<Users> selectUserByBirthAndEmail(Users user);
	Users selectUserByIdAndAnswer(Users user);
}
