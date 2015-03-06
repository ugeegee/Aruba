package com.bmj.dao;

import java.util.List;

import com.bmj.entity.Comment;

public interface CommentDao {
	int insertComment(Comment comment);
	int updateComment(Comment comment);
	int deleteComment(String userId);
	List<Comment> selectAllNoticeComment();
	List<Comment> selectAllFreeComment();
	List<Comment> selectAllQnAComment();
	Comment selectComment(int commentNumber);
	Integer CountByUserId(String userId);
	
	int selectFlagByCommentNo(int commentNumber);
	int deleteCommentByCommentNo(int commentNumber);
	List<Integer> selectCommentNoListByUserId(String userId);
	int updateUserIdByCommentNo(int commentNumber);
}
