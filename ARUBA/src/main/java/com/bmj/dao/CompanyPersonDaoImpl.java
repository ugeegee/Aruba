package com.bmj.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.entity.CompanyPerson;
@Repository
public class CompanyPersonDaoImpl implements CompanyPersonDao {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(CompanyPersonDaoImpl.class);
	}
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.CompanyPerson.";
	@Override
	public int insertCompanyPerson(CompanyPerson companyperson) {
		logger.trace("수업 : 여기는 ComapnPersonDaoImpl.....!!!" + companyperson);		
		String stmt = namespace + "insertCompanyPerson";
		return sqlSession.insert(stmt, companyperson);
	}
	
	@Override
	public CompanyPerson selectCompanyPersonByUserId(String userId) {
		logger.trace("!!!!!!사장이 아이디로 CompanyCode찾기위해 DB로 가기전");
		String stmt = namespace + "selectCompanyPersonByUserId";
		return sqlSession.selectOne(stmt, userId);
	}

	@Override
	public List<CompanyPerson> selectByCompanyCode(int companyCode) {
		logger.trace("수업 여기는 Dao : " + companyCode);
		String stmt = namespace + "selectByCompanyCode";
		return sqlSession.selectList(stmt, companyCode);
	}

	@Override
	public int insertCompanyOwner(CompanyPerson companyperson) {
		logger.trace("!!사장회사에 추가하러DB가기전!!");		
		String stmt = namespace + "insertCompanyOwner";
		return sqlSession.insert(stmt, companyperson);
	}
	
	@Override
	public List<Integer> selectComCodeByUserId(String userId){
		String stmt = namespace + "selectComCodeByUserId";
		List<Integer> result = sqlSession.selectList(stmt, userId);
		return result;
	}
	
	@Override
	public int insertCompanyEmployee(CompanyPerson companyperson) {
		String stmt = namespace + "insertCompanyEmployee";
		return sqlSession.insert(stmt, companyperson);
	}

	@Override
	public int updateSalary(CompanyPerson companyperson) {
		String stmt = namespace + "updateSalary";
		return sqlSession.update(stmt, companyperson);
	}

	@Override
	public int selectMemberIdbyUserId(String userId) {
		String stmt = namespace + "selectMemberIdbyUserId";
		return sqlSession.selectOne(stmt, userId);
	}

	@Override
	public String selectUserIdbyMemberId(int memberId) {
		String stmt = namespace + "selectUserIdbyMemberId";
		return sqlSession.selectOne(stmt, memberId);
	}

	@Override
	public int deleteCompanyPersonByUserId(String userId) {
		String stmt = namespace + "deleteCompanyPersonByUserId";
		return sqlSession.delete(stmt, userId);
	}
	@Override
	public int selectMemberIdbyCompanyPerson(CompanyPerson companyperson) {
		String stmt = namespace + "selectMemberIdbyCompanyPerson";
		return sqlSession.selectOne(stmt, companyperson);
	}

	@Override
	public List<Integer> selectMemberIdListbyUserId(String userId) {
		String stmt = namespace + "selectMemberIdListbyUserId";
		return sqlSession.selectList(stmt, userId);
	}

	@Override
	public int deleteCompanyPersonByComCodeAndUserId(CompanyPerson companyperson) {
		String stmt = namespace + "deleteCompanyPersonByComCodeAndUserId";
		return sqlSession.delete(stmt, companyperson);
	}

	@Override
	public String selectOwnerIdByComCode(int companyCode) {
		String stmt = namespace + "selectOwnerIdByComCode";
		return sqlSession.selectOne(stmt, companyCode);
	}

	/*@Override
	public CompanyPerson selectCompanyPersonByPerson(CompanyPerson person) {
		String stmt = namespace + "selectCompanyPersonByPerson";
		return sqlSession.selectOne(stmt, person);
	}*/
}
