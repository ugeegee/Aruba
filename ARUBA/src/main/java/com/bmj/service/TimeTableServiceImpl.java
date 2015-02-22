package com.bmj.service;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.dao.TimeTableDao;
import com.bmj.entity.Stats;
import com.bmj.entity.TimeTable;

@Service
@Transactional(rollbackFor=com.bmj.exception.ServiceFailException.class)
public class TimeTableServiceImpl implements TimeTableService {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(TimeTableServiceImpl.class);
	}
	@Autowired
	TimeTableDao dao;
	
	@Override
	public int insertTimeTable(TimeTable timetable) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!");
		int result = dao.insert(timetable);
		return result;
	}

	@Override
	public List<TimeTable> selectByCompanyCode(int CompanyCode) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!" + CompanyCode);
		List<TimeTable> timetable = dao.selectByCompanyCode(CompanyCode);
		return timetable;
	}

	@Override
	public List<TimeTable> selectByMemberId(int memberId) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!" + memberId);
		List<TimeTable> timetable = dao.selectByMemberId(memberId);
		return timetable;
	}

	@Override
	public List<Stats> selectStatsByMemberId(int memberId) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!" + memberId);
		List<Stats> result = dao.selectStatsByMemberId(memberId);
		return result;
	}

	@Override
	public List<Stats> selectStatsByCompanyCode(int companyCode) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!" + companyCode);
		List<Stats> result = dao.selectStatsByCompanyCode(companyCode);
		return result;
	}

	@Override
	public int selectKeybyTime(TimeTable timetable) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!" + timetable);
		int key = dao.selectKeybyTime(timetable);
		return key;
	}

	@Override
	public int updateTimeTable(TimeTable updateTable) {
		logger.trace("여기는 Time Table 서비스~~~~~~~~~~~~~~~~~~~~~!" + updateTable);
		int result = dao.updateTimeTable(updateTable);
		return result;
	}

	@Override
	public int deleteTimeTableByMemberId(int memberId) {
		int result = dao.deleteTimeTableByMemberId(memberId);
		return result;
	}

}
