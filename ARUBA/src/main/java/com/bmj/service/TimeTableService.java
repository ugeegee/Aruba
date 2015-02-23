package com.bmj.service;
import java.util.List;

import com.bmj.entity.Stats;
import com.bmj.entity.TimeTable;

public interface TimeTableService {
	int insertTimeTable(TimeTable timetable);
	int deleteTimeTableByMemberId(int memberId);
	List<TimeTable> selectByCompanyCode(int CompanyCode);
	List<TimeTable> selectByMemberId(int memberId);
	List<Stats> selectStatsByMemberId(int memberId);
	List<Stats> selectStatsByCompanyCode(int companyCode);
	int selectKeybyTime(TimeTable timetable);
	int updateTimeTable(TimeTable updateTable);
	double selectCountByRuntime(TimeTable runtimesalary);
}
