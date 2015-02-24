package com.bmj.dao;


import com.bmj.entity.Company;

public interface CompanyDao {
	int insert(Company company);
	int update(Company company);
	int deleteCompanyByCompanyCode(int companyCode);
	Company select(Company company);
	Company selectCompanyByCodeAndTel(Company company);
	Company selectByCompanyCode(int companyCode);
}
