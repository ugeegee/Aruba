package com.bmj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.dao.ReplyDao;
import com.bmj.entity.Reply;
@Service
@Transactional(rollbackFor=com.bmj.exception.ServiceFailException.class)
public class ReplyServiceImpl implements ReplyService {

	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(ReplyServiceImpl.class);
	}
	
	@Autowired
	ReplyDao dao;
	
	@Override
	public int insertReply(Reply reply) {
		int result = dao.insertReply(reply);
		return result;
	}
	
	@Override
	public int updateReply(Reply reply) {
		int result = dao.updateReply(reply);
		return result;
	}

	@Override
	public int deleteReply(String userId) {
		int result = dao.deleteReply(userId);
		return result;
	}

	@Override
	public List<Reply> selectAllReply(int commentNumber) {
		List<Reply> result = dao.selectAllReply(commentNumber);
		return result;
	}

	@Override
	public int deleteReplyByCommentNo(int commentNumber) {
		int result = dao.deleteReplyByCommentNo(commentNumber);
		return result;
	}

	@Override
	public int deleteReplyByReplyNo(int replyNumber) {
		int result = dao.deleteReplyByReplyNo(replyNumber);
		return result;
	}
}
