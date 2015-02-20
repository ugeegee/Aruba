package com.bmj.service;

import java.util.List;

import com.bmj.entity.Message;

public interface MessageService {
	int insertMessage(Message message);
	int updateMesageFlagByMsgNum(int messageNumber);
	List<Message> selectMessageByUserId(String userId);
	List<Message> selectMessageByComCode(int companyCode);
}
