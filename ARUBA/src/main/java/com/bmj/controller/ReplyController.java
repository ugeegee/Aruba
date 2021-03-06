package com.bmj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.bmj.entity.Comment;
import com.bmj.entity.Reply;
import com.bmj.entity.Users;
import com.bmj.service.CommentService;
import com.bmj.service.ReplyService;

@Controller
@SessionAttributes("addReply")
public class ReplyController {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(ReplyController.class);
	}
	
	@Autowired
	ReplyService rservice;
	@Autowired
	CommentService cservice;
	
	@RequestMapping(value = "/registerReply", method = RequestMethod.POST)
	// 댓글 작성 성공시
	public String registerReply(@RequestParam int commentNumber,
			@RequestParam String replyContent, Model model, HttpSession session) {
		Reply reply = new Reply();
		Users loginUser = (Users) session.getAttribute("addUser");
		reply.setUserId(loginUser.getUserId());
		reply.setCommentNumber(commentNumber);
		reply.setReplyContent(replyContent);
		rservice.insertReply(reply);
		model.addAttribute("addReply", reply);
		
		int trunbackFlag = cservice.selectFlagByCommentNo(commentNumber);
		model.addAttribute("turnbackFlag", trunbackFlag);
		
		return "redirect:/showReplyList?no="+commentNumber;
	}
	
	@RequestMapping(value = "/deleteReply", method = RequestMethod.GET)
	// 댓글 삭제 성공시
	public String deleteReplySuccess(@RequestParam int replyNumber, @RequestParam int commentNumber) {
		//댓글지우고
		rservice.deleteReplyByReplyNo(replyNumber);
		//글보던페이지로 바로 이동하게
		return "redirect:/showReplyList?no="+commentNumber;
	}

	@RequestMapping(value = "/showReplyList", method = RequestMethod.GET)
	//글보기
	public String showCommentContent(@RequestParam int no, Model model, HttpSession session) {
		model.addAttribute("addReply", new Reply());
		Comment selectedComment = cservice.selectComment(no);
		List<Reply> replyList = rservice.selectAllReply(no);
		model.addAttribute("selectedComment", selectedComment);
		logger.trace("수업 : " + selectedComment);
		model.addAttribute("replyList", replyList);
		
		Users loginUser = (Users) session.getAttribute("addUser");
		model.addAttribute("loginId", loginUser.getUserId());
		return "/board/addReply";	
	}
	
	@RequestMapping(value = "/deleteComment", method = RequestMethod.GET)
	//글삭제
	public String deleteCommentSuccess(@RequestParam int commentNumber, Model model) {
		//글을 지우기전에 되돌아갈 flag얻어오고
		int trunbackFlag = cservice.selectFlagByCommentNo(commentNumber);
		model.addAttribute("turnbackFlag", trunbackFlag);
		
		//댓글지움
		rservice.deleteReplyByCommentNo(commentNumber);
		//글지움
		cservice.deleteCommentByCommentNo(commentNumber);
		
		return "/board/delete";	
	}
}
