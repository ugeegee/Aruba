package com.bmj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bmj.dao.MessageDao;
import com.bmj.entity.Message;

@Service
public class MessageserviceImpl implements MessageService {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(MessageserviceImpl.class);
	}
	
	@Autowired
	MessageDao dao;
	@Override
	public int insertMessage(Message message) {
		int result = dao.insertMessage(message);
		return result;
	}
	@Override
	public int updateMesageFlagByMsgNum(int messageNumber) {
		int result = dao.updateMesageFlagByMsgNum(messageNumber);
		return result;
	}
	@Override
	public List<Message> selectMessageByUserId(String userId) {
		List<Message> result = dao.selectMessageByUserId(userId);
		return result;
	}
	@Override
	public List<Message> selectMessageByComCode(int companyCode) {
		List<Message> result = dao.selectMessageByComCode(companyCode);
		return result;
	}
	@Override
	public int deleteMessageByUserId(String userId) {
		int result = dao.deleteMessageByUserId(userId);
		return result;
	}
	@Override
	public int deleteMessageByCompanyCode(int companyCode) {
		int result = dao.deleteMessageByCompanyCode(companyCode);
		return result;
	}



}
