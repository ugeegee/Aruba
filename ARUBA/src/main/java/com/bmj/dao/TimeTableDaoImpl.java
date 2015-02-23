package com.bmj.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bmj.entity.Stats;
import com.bmj.entity.TimeTable;

@Repository
public class TimeTableDaoImpl implements TimeTableDao {
	private static final Logger logger;
	static {
		logger = LoggerFactory.getLogger(TimeTableDaoImpl.class);
	}
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.TimeTable.";

	@Override
	public int insert(TimeTable timetable) {
		String stmt = namespace + "insertTimeTable";
		return sqlSession.insert(stmt, timetable);
	}

	@Override
	public List<TimeTable> selectByCompanyCode(int CompanyCode) {
		logger.trace("수업 여기는 Dao... !" + CompanyCode);
		String stmt = namespace + "selectByCompanyCode";
		return sqlSession.selectList(stmt, CompanyCode);
	}

	@Override
	public List<TimeTable> selectByMemberId(int memberId) {
		logger.trace("수업 여기는 Dao... !" + memberId);
		String stmt = namespace + "selectByMemberId";
		return sqlSession.selectList(stmt, memberId);
	}

	@Override
	public List<Stats> selectStatsByMemberId(int memberId) {
		String stmt = namespace + "selectStatsByMemberId";
		return sqlSession.selectList(stmt, memberId);
	}

	@Override
	public List<Stats> selectStatsByCompanyCode(int companyCode) {
		String stmt = namespace + "selectStatsBycompanyCode";
		return sqlSession.selectList(stmt, companyCode);
	}

	@Override
	public int selectKeybyTime(TimeTable timetable) {
		String stmt = namespace + "selectKeybyTime";
		return sqlSession.selectOne(stmt, timetable);
	}

	@Override
	public int updateTimeTable(TimeTable updateTable) {
		String stmt = namespace + "updateTimeTable";
		return sqlSession.update(stmt, updateTable);
	}

	@Override
	public int deleteTimeTableByMemberId(int memberId) {
		String stmt = namespace +"deleteTimeTableByMemberId";
		return sqlSession.delete(stmt, memberId);
	}

	@Override
	public double selectCountByRuntime(TimeTable runtimesalary) {
		String stmt = namespace + "selectCountByRuntime";
		return sqlSession.selectOne(stmt, runtimesalary);
	}
}
