package com.bmj.dao;

import java.util.List;

import com.bmj.entity.Comment;
import com.bmj.entity.Reply;

public interface ReplyDao {
	int insertReply(Reply reply);
	int updateReply(Reply reply);
	int deleteReply(String userId);
	List<Reply> selectAllReply(int commentNumber);
	
	int deleteReplyByCommentNo(int commentNumber);
}
