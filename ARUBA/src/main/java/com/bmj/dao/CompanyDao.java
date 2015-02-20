package com.bmj.dao;

import java.util.List;

import com.bmj.entity.Company;

public interface CompanyDao {
	int insert(Company company);
	int update(Company company);
	Company select(Company company);
	Company selectCompanyByCodeAndTel(Company company);
	Company selectByCompanyCode(int companyCode);
}
