package com.bmj.dao;

import java.util.List;

import com.bmj.entity.CompanyPerson;

public interface CompanyPersonDao {
	int insertCompanyOwner(CompanyPerson companyperson);
	int insertCompanyEmployee(CompanyPerson companyperson);
	int insertCompanyPerson(CompanyPerson companyperson);
	int deleteCompanyPersonByUserId(String userId);
	int deleteCompanyPersonByComCodeAndUserId(CompanyPerson companyperson);
	CompanyPerson selectCompanyPersonByUserId(String userId);
	/*int selectComCodeByUserId(String userId);*/
	List<Integer> selectComCodeByUserId(String userId);
	List<CompanyPerson> selectByCompanyCode(int companyCode);
	int updateSalary(CompanyPerson companyperson);
	int selectMemberIdbyUserId(String userId);
	String selectUserIdbyMemberId(int memberId);
	int selectMemberIdbyCompanyPerson(CompanyPerson companyperson);
	List<Integer> selectMemberIdListbyUserId(String userId);
	/*CompanyPerson selectCompanyPersonByPerson(CompanyPerson person);*/
}
