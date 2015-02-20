package com.bmj.service;

import java.util.List;

import com.bmj.entity.Company;

public interface CompanyService {
	int insertCompany(Company company);
	int updateCompany(Company company);
	Company seelctCompany(Company company);
	Company selectCompanyByCodeAndTel(Company company);
	Company selectCompanyByCompanyCode(int companyCode);
}
