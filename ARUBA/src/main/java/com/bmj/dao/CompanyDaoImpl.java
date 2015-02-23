package com.bmj.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.entity.Company;
import com.bmj.exception.RegisterJobException;

@Repository 
@Transactional(rollbackFor=com.bmj.exception.RegisterJobException.class)
public class CompanyDaoImpl implements CompanyDao {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(CompanyDaoImpl.class);
	}
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.Companys.";
	@Override
	public int insert(Company company) {
		logger.trace("수업 : 여기는 DaoImpl......!" + company);
		if(company.getHolidayComm() == 0) {
			company.setHolidayComm(0);
			
		} 
		if (company.getNightComm() == 0) {
			company.setNightComm(0);
		}
		logger.trace("수업 : ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ" + company);
		String stmt = namespace + "insertCompany";
		return sqlSession.insert(stmt, company);
	}
	@Override
	public Company select(Company company){
		String stmt = namespace + "selectCompany";
		return sqlSession.selectOne(stmt, company);
	}
	@Override
	public Company selectByCompanyCode(int companyCode) {
		String stmt = namespace + "selectCompanyByCompanyCode";
		return sqlSession.selectOne(stmt, companyCode);
	}
	@Override
	public int update(Company company) {
		String stmt = namespace + "updateCompany";
		return sqlSession.update(stmt, company);
	}
	@Override
	public Company selectCompanyByCodeAndTel(Company company) throws RegisterJobException{
		String stmt = namespace + "selectCompanyByCodeAndTel";
		Company result = sqlSession.selectOne(stmt, company);
		if(sqlSession.selectOne(stmt, company) == null){
			throw new RegisterJobException("!!!!회사코드,전화번호로 회사조회 결과 = NULL");
		}
		return result;
	}
	@Override
	public int deleteCompanyByCompanyCode(int companyCode) {
		String stmt = namespace + "deleteCompanyByCompanyCode";
		return sqlSession.delete(stmt, companyCode);
	}
	
}
