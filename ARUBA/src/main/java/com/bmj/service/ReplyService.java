package com.bmj.service;

import java.util.List;

import com.bmj.entity.Reply;

public interface ReplyService {
	int insertReply(Reply reply);
	int updateReply(Reply reply);
	int deleteReply(String userId);
	List<Reply> selectAllReply(int commentNumber);
	
	int deleteReplyByCommentNo(int commentNumber);
	int deleteReplyByReplyNo(int replyNumber);
	List<Integer> selectReplyNoListByUserId(String userId);
	int updateUserIdByReplyNo(int replyNumber);
}
