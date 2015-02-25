package com.bmj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.dao.CompanyDao;
import com.bmj.entity.Company;

@Service
public class CompanyServiceImpl implements CompanyService {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(CompanyServiceImpl.class);
	}
	@Autowired
	CompanyDao dao;
	@Override
	public int insertCompany(Company company) {
		logger.trace("여기는 서비스~~~~~~~~~~~~~~~~~~~~~!");
		int result = dao.insert(company);
		return result;
	}
	@Override
	public int updateCompany(Company company) {
		int result = dao.update(company);
		return result;
	}
	@Override
	public Company seelctCompany(Company company) {
		Company result = dao.select(company);
		logger.trace("Ccccccccccccccccc" + company);
		return result;
	}
	@Override
	public Company selectCompanyByCodeAndTel(Company company) {
		Company result = dao.selectCompanyByCodeAndTel(company);
		return result;
	}
	@Override
	public Company selectCompanyByCompanyCode(int companyCode) {
		Company result = dao.selectByCompanyCode(companyCode);
		return result;
	}
	@Override
	public int deleteCompanyByCompanyCode(int companyCode) {
		int result = dao.deleteCompanyByCompanyCode(companyCode);
		return result;
	}
	

}
