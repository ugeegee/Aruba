package com.bmj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.dao.CompanyPersonDao;
import com.bmj.entity.CompanyPerson;

@Service
public class CompanyPersonServiceImpl implements CompanyPersonService {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(CompanyPersonServiceImpl.class);
	}
	@Autowired
	CompanyPersonDao dao;
	
	@Override
	public int insertCompanyPerson(CompanyPerson companyperson) {
		logger.trace("여기는 서비스~~~~~~~~~~~~~~~!");
		int result = dao.insertCompanyPerson(companyperson);
		return result;
	}

	@Override
	public CompanyPerson selectCompanyPersonByUserId(String userId) {
		CompanyPerson result = dao.selectCompanyPersonByUserId(userId);
		if(result == null){
			logger.trace("nulllllllllllllllllllllllllllllllllllllllllllll");
		}
		return result;
	}

	@Override
	public List<CompanyPerson> selectByCompanyCode(int companyCode) {
		logger.trace("숙제 서비스 : " + companyCode);
		List<CompanyPerson> result = dao.selectByCompanyCode(companyCode);
		return result;
	}

	@Override
	public int insertCompanyOwner(CompanyPerson companyperson) {
		logger.trace("여기는 서비스~~~~~~~~~~~~~~~!");
		int result = dao.insertCompanyOwner(companyperson);
		return result;
	}

	/*@Override
	public int selectComCodeByUserId(String userId) {
		int result = dao.selectComCodeByUserId(userId);
		return result;
	}*/
	@Override
	public List<Integer> selectComCodeByUserId(String userId) {
		List<Integer> result = dao.selectComCodeByUserId(userId);
		return result;
	}
	
	@Override
	public int insertCompanyEmployee(CompanyPerson companyperson) {
		int result = dao.insertCompanyEmployee(companyperson);
		return result;
	}

	@Override
	public int updateSalary(CompanyPerson companyperson) {
		int result = dao.updateSalary(companyperson);
		return result;
	}

	@Override
	public int selectMemberIdbyUserId(String userId) {
		int result = dao.selectMemberIdbyUserId(userId);
		return result;
	}

	@Override
	public String selectUserIdbyMemberId(int memberId) {
		String userId = dao.selectUserIdbyMemberId(memberId);
		return userId;
	}

	@Override
	public int deleteCompanyPersonByUserId(String userId) {
		int result = dao.deleteCompanyPersonByUserId(userId);
		return result;
	}
	@Override
	public int selectMemberIdbyCompanyPerson(CompanyPerson companyperson) {
		int memberId = dao.selectMemberIdbyCompanyPerson(companyperson);
		return memberId;
	}

	@Override
	public List<Integer> selectMemberIdListbyUserId(String userId) {
		List<Integer> result = dao.selectMemberIdListbyUserId(userId);
		return result;
	}

	@Override
	public int deleteCompanyPersonByComCodeAndUserId(CompanyPerson companyperson) {
		int result = dao.deleteCompanyPersonByComCodeAndUserId(companyperson);
		return result;
	}

	@Override
	public String selectOwnerIdByComCode(int companyCode) {
		String result = dao.selectOwnerIdByComCode(companyCode);
		return result;
	}

	/*@Override
	public CompanyPerson selectCompanyPersonByPerson(CompanyPerson person) {
		CompanyPerson companyperson = dao.selectCompanyPersonByPerson(person);
		return companyperson;
	}*/

}
