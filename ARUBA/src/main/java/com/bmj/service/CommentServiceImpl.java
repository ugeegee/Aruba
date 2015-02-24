package com.bmj.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bmj.dao.CommentDao;
import com.bmj.entity.Comment;

@Service
@Transactional(rollbackFor=com.bmj.exception.ServiceFailException.class)
public class CommentServiceImpl implements CommentService {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(CommentServiceImpl.class);
	}
	
	@Autowired
	CommentDao dao;

	@Override
	public int insertComment(Comment comment) {
		int result = dao.insertComment(comment);
		return result;
	}
	
	@Override
	public int updateComment(Comment comment) {
		int result = dao.updateComment(comment);
		return result;
	}
	
	@Override
	public int deleteComment(String userId) {
		int result = dao.deleteComment(userId);
		return result;
	}

	@Override
	public Comment selectComment(int commentNumber) {
		Comment result = dao.selectComment(commentNumber);
		if(result == null){
			logger.trace("nulllllllllllllllllllllllllllllllllllllllllllll");
		}
		return result;
	}

	@Override
	public Integer CountByUserId(String userId) {
		Integer result = dao.CountByUserId(userId);
		return result;
	}

	@Override
	public List<Comment> selectAllNoticeComment() {
		List<Comment> result = dao.selectAllNoticeComment();
		return result;
	}

	@Override
	public List<Comment> selectAllFreeComment() {
		List<Comment> result = dao.selectAllFreeComment();
		return result;
	}

	@Override
	public List<Comment> selectAllQnAComment() {
		List<Comment> result = dao.selectAllQnAComment();
		return result;
	}

	@Override
	public int selectFlagByCommentNo(int commentNumber) {
		int result = dao.selectFlagByCommentNo(commentNumber);
		return result;
	}

	@Override
	public int deleteCommentByCommentNo(int commentNumber) {
		int result = dao.deleteCommentByCommentNo(commentNumber);
		return result;
	}
}
