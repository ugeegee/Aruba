package com.bmj.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bmj.entity.Reply;
@Repository
public class ReplyDaoImpl implements ReplyDao {
	
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(ReplyDaoImpl.class);
	}
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.Reply.";


	@Override
	public int insertReply(Reply reply) {
		String stmt = namespace + "insertReply";
		return sqlSession.insert(stmt, reply);
	}
	
	@Override
	public int updateReply(Reply reply) {
		String stmt = namespace + "updateReply";
		return sqlSession.update(stmt, reply);
	}

	@Override
	public int deleteReply(String userId) {
		String stmt = namespace + "deleteReply";
		return sqlSession.delete(stmt, userId);
	}

	@Override
	public List<Reply> selectAllReply(int commentNumber) {
		String stmt = namespace + "selectAllReply";
		List<Reply> replies = null;
		replies = sqlSession.selectList(stmt, commentNumber);
		return replies;
	}

	@Override
	public int deleteReplyByCommentNo(int commentNumber) {
		String stmt = namespace + "deleteReplyByCommentNo";
		return sqlSession.delete(stmt, commentNumber);
	}

	@Override
	public int deleteReplyByReplyNo(int replyNumber) {
		String stmt = namespace +"deleteReplyByReplyNo";
		return sqlSession.delete(stmt, replyNumber);
	}

	@Override
	public List<Integer> selectReplyNoListByUserId(String userId) {
		String stmt = namespace + "selectReplyNoListByUserId";
		return sqlSession.selectList(stmt, userId);
	}

	@Override
	public int updateUserIdByReplyNo(int replyNumber) {
		String stmt = namespace + "updateUserIdByReplyNo";
		return sqlSession.update(stmt, replyNumber);
	}
}
