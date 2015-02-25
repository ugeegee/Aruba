package com.bmj.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.entity.Users;
import com.bmj.exception.LoginFailException;

@Repository
@Transactional(rollbackFor=com.bmj.exception.LoginFailException.class)
public class UsersDaoImpl implements UsersDao {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(UsersDaoImpl.class);
	}
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.Users.";
	@Override
	public Integer getUsersCount() {
		String stmt = namespace + "selectUsersCnt";
		return sqlSession.selectOne(stmt);
	}
	@Override
	public int insertUser(Users user) {
		String stmt = namespace + "insertUser";
		return sqlSession.insert(stmt, user);
	}
	@Override
	public int updateUser(Users user) {
		String stmt = namespace + "updateUser";
		return sqlSession.update(stmt, user);
	}
	@Override
	public int deleteUser(Users user) {
		String stmt = namespace + "deleteUser";
		return sqlSession.update(stmt, user);
	}
	@Override
	public int updatePassUser(Users user) {
		String stmt = namespace + "updatePassUser";
		return sqlSession.update(stmt, user);
	}
	@Override
	public Users loginUser(Users user) {
		String stmt= namespace + "loginUser";
		Users result = sqlSession.selectOne(stmt, user);
		if( sqlSession.selectOne(stmt, user) == null){
			throw new LoginFailException("login결과 = NULL");
		}
		
		return result;
	}
	@Override
	public int countByUserId(String userId) {
		String stmt = namespace + "countByUserId";
		return sqlSession.selectOne(stmt, userId);
	}
	@Override
	public Users selectUserByUserId(String userId) {
		String stmt = namespace + "selectUserByUserId";
		return sqlSession.selectOne(stmt, userId);
	}
	@Override
	public Users selectUserByBirthAndEmail(Users user) {
		String stmt = namespace + "selectUserByBirthAndEmail";
		return sqlSession.selectOne(stmt, user);
	}


}
