package com.bmj.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bmj.entity.Message;

@Repository
public class MessageDaoImpl implements MessageDao {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(MessageDaoImpl.class);
	}
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.Message.";
	
	@Override
	public int insertMessage(Message message) {
		String stmt = namespace + "insertMessage";
		return sqlSession.insert(stmt, message);
	}
	@Override
	public int updateMesageAcceptFlagByMsgNum(int messageNumber) {
		String stmt = namespace +"updateMesageAcceptFlagByMsgNum";
		return sqlSession.update(stmt, messageNumber);
	}
	@Override
	public List<Message> selectMessageByUserId(String userId) {
		String stmt = namespace + "selectMessageByUserId";
		return sqlSession.selectList(stmt, userId);
	}
	@Override
	public List<Message> selectMessageByComCode(int companyCode) {
		String stmt = namespace + "selectMessageByComCode";
		return sqlSession.selectList(stmt, companyCode);
	}
	@Override
	public int deleteMessageByUserId(String userId) {
		String stmt = namespace + "deleteMessageByUserId";
		return sqlSession.delete(stmt, userId);
	}
	@Override
	public int deleteMessageByCompanyCode(int companyCode) {
		String stmt = namespace + "deleteMessageByCompanyCode";
		return sqlSession.delete(stmt, companyCode);
	}
	@Override
	public int updateMesageRejectFlagByMsgNum(int messageNumber) {
		String stmt = namespace + "updateMesageRejectFlagByMsgNum";
		return sqlSession.update(stmt, messageNumber);
	}
	@Override
	public int countUncheckedFlagByUserId(String userId) {
		String stmt = namespace + "countUncheckedFlagByUserId";
		return sqlSession.selectOne(stmt, userId);
	}
	@Override
	public Message selectUncheckedMessageByMessage(Message message) {
		String stmt = namespace + "selectUncheckedMessageByMessage";
		return sqlSession.selectOne(stmt, message);
	}
	

}
