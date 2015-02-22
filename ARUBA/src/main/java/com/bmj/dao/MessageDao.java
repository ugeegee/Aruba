package com.bmj.dao;

import java.util.List;

import com.bmj.entity.Message;


public interface MessageDao {
	int insertMessage(Message message);
	int updateMesageFlagByMsgNum(int messageNumber);
	int deleteMessageByUserId(String userId);
	List<Message> selectMessageByUserId(String userId);
	List<Message> selectMessageByComCode(int companyCode);
}
