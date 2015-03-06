package com.bmj.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bmj.entity.Comment;

@Repository
public class CommentDaoImpl implements CommentDao {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(CommentDaoImpl.class);
	}
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static final String namespace = "mybatis.mapper.Comment.";

	@Override
	public int insertComment(Comment comment) {
		logger.trace("수업 : 여기는 DaoImpl......!" + comment);
		String stmt = namespace + "insertComment";
		return sqlSession.insert(stmt, comment);
	}
	
	@Override
	public int updateComment(Comment comment) {
		String stmt = namespace + "updateComment";
		return sqlSession.update(stmt, comment);
	}
	
	@Override
	public int deleteComment(String userId) {
		String stmt = namespace + "deleteComment";
		return sqlSession.delete(stmt, userId);
	}

	@Override
	public Comment selectComment(int commentNumber) {
		String stmt = namespace + "selectComment";
		return sqlSession.selectOne(stmt, commentNumber);
	}

	@Override
	public Integer CountByUserId(String userId) {
		String stmt = namespace + "selectCommentNumberByUserId";
		return sqlSession.selectOne(stmt, userId);
	}

	@Override
	public List<Comment> selectAllNoticeComment() {
		String stmt = namespace + "selectAllNoticeComment";
		List<Comment> comments = null;
		comments = sqlSession.selectList(stmt);
		return comments;
	}

	@Override
	public List<Comment> selectAllFreeComment() {
		String stmt = namespace + "selectAllFreeComment";
		List<Comment> comments = null;
		comments = sqlSession.selectList(stmt);
		return comments;
	}

	@Override
	public List<Comment> selectAllQnAComment() {
		String stmt = namespace + "selectAllQnAComment";
		List<Comment> comments = null;
		comments = sqlSession.selectList(stmt);
		return comments;
	}

	@Override
	public int selectFlagByCommentNo(int commentNumber) {
		String stmt = namespace + "selectFlagByCommentNo";
		return sqlSession.selectOne(stmt, commentNumber);
	}

	@Override
	public int deleteCommentByCommentNo(int commentNumber) {
		String stmt = namespace + "deleteCommentByCommentNo";
		return sqlSession.delete(stmt, commentNumber);
	}

	@Override
	public List<Integer> selectCommentNoListByUserId(String userId) {
		String stmt = namespace + "selectCommentNoListByUserId";
		return sqlSession.selectList(stmt, userId);
	}

	@Override
	public int updateUserIdByCommentNo(int commentNumber) {
		String stmt = namespace + "updateUserIdByCommentNo";
		return sqlSession.update(stmt, commentNumber);
	}
}
