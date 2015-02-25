package com.bmj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.dao.UsersDao;
import com.bmj.entity.Users;

@Service
public class UsersServiceImpl implements UsersService {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(UsersServiceImpl.class);
	}
	
	@Autowired
	UsersDao dao;
	@Override
	public Integer getUsersCount() {
		Integer result = dao.getUsersCount();
		return result;
	}
	@Override
	public int insertUser(Users user) {
		int result = dao.insertUser(user);
		return result;
	}
	@Override
	public int updateUser(Users user) {
		int result = dao.updateUser(user);
		return result;
	}
	@Override
	public int deleteUser(Users user) {
		int result = dao.deleteUser(user);
		return result;
	}
	@Override
	public int updatePassUser(Users user) {
		int result = dao.updatePassUser(user);
		return result;
	}
	@Override
	public Users loginUser(Users user) {
		Users result = dao.loginUser(user);
		logger.trace("DB에서 login!! 해온 결과!!" + result.toString());
		return result;
	}
	@Override
	public int countByUserId(String userId) {
		int result = dao.countByUserId(userId);
		return result;
	}
	@Override
	public Users selectUserByUserId(String userId) {
		Users result = dao.selectUserByUserId(userId);
		return result;
	}
	@Override
	public List<Users> selectUserByBirthAndEmail(Users user) {
		List<Users> result = dao.selectUserByBirthAndEmail(user);
		return result;
	}
	@Override
	public Users selectUserByIdAndAnswer(Users user) {
		Users result = dao.selectUserByIdAndAnswer(user);
		return result;
	}
	
	
}
