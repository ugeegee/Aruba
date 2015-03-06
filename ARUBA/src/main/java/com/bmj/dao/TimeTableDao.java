package com.bmj.dao;

import java.util.List;

import com.bmj.entity.Stats;
import com.bmj.entity.TimeTable;

public interface TimeTableDao {
	int insert(TimeTable timetable);
	int deleteTimeTableByMemberId(int memberId);
	int deleteTimeTableByCompanyCode(int companyCode);
	List<TimeTable> selectByCompanyCode(int CompanyCode);
	List<TimeTable> selectByMemberId(int memberId);
	List<Stats> selectStatsByMemberId(int memberId);
	List<Stats> selectStatsByCompanyCode(int companyCode);
	List<Stats> selectNightStatsByCompanyCode(int companyCode);
	int selectKeybyTime(TimeTable timetable);
	int updateTimeTable(TimeTable updateTable);
	double selectCountByRuntime(TimeTable runtimesalary);
	int deleteTimeTableByTimekey(int timekey);
}
