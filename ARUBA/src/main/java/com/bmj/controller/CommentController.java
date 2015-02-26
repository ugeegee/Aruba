package com.bmj.controller;

import java.util.Date;
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

@Controller
@SessionAttributes("addComment")
public class CommentController {
	private final static Logger logger;
	static {
		logger = LoggerFactory.getLogger(CommentController.class);
	}

	@Autowired
	CommentService cservice;
	
	@RequestMapping(value = "/writeComment", method = RequestMethod.GET)
	// 글쓰기버튼 눌렀을 때
	public String writeCommentGo(@RequestParam int flag, Model model) {
		model.addAttribute("nowFlag", flag);
		return "/board/writeComment";
	}
	@RequestMapping(value = "/registerComment", method = RequestMethod.POST)
	// 게시글 작성하러옴
	public String registerComment(@RequestParam String commentTitle,@RequestParam String commentContent, 
			@RequestParam int flag, Model model, HttpSession session) {
		Comment comment = new Comment();
		Users loginUser = (Users) session.getAttribute("addUser");
		//Date date = new Date();
		//regDate = new Date();
		comment.setUserId(loginUser.getUserId());
		comment.setCommentTitle(commentTitle);
		comment.setCommentContent(commentContent);
		comment.setRegDate(new Date());
		comment.setFlag(flag);
		cservice.insertComment(comment);
		model.addAttribute("addComment", comment);
		
		model.addAttribute("turnbackFlag", flag);
		
		return "/board/success";
	}
	
	@RequestMapping(value = "/modifyComment", method = RequestMethod.GET)
	//글수정페이지로
	public String modifyCommentGo(@RequestParam int commentNumber, Model model, HttpSession session) {
		
		Comment selectedComment = cservice.selectComment(commentNumber);
		model.addAttribute("selectedComment", selectedComment);
		logger.trace("수업 : " + selectedComment);
		
		/*Users loginUser = (Users) session.getAttribute("addUser");
		model.addAttribute("loginId", loginUser.getUserId());*/
		return "/board/modifyComment";	
	}
	@RequestMapping(value = "/modifyComment", method = RequestMethod.POST)
	//글수정하러옴
	public String modifyCommentSuccessGo(@RequestParam int commentNumber, @RequestParam String commentTitle, @RequestParam String commentContent,
										Model model, HttpSession session) {
		
		
		Comment selectedComment = cservice.selectComment(commentNumber);
		model.addAttribute("selectedComment", selectedComment);
		logger.trace("수업 : " + selectedComment);
		
		Comment comment = new Comment();
		comment.setCommentNumber(commentNumber);
		comment.setCommentTitle(commentTitle);
		comment.setCommentContent(commentContent);
		comment.setRegDate(new Date());
		
		cservice.updateComment(comment);
		
		return "redirect:/showReplyList?no="+commentNumber;	
	}
	
	@RequestMapping(value = "/notice")
	public String showNoticeList(Model model, HttpSession session) {
		model.addAttribute("addComment", new Comment());
		List<Comment> commentList = cservice.selectAllNoticeComment();
		model.addAttribute("commentList", commentList);
		
		Users loginUser = (Users) session.getAttribute("addUser"); 
		model.addAttribute("loginId", loginUser.getUserId());
		/*return "/board/noticeBoard";*/
		return "/board/noticeTest";
	}
	
	@RequestMapping(value = "/free")
	public String showFreeList(Model model) {
		model.addAttribute("addComment", new Comment());
		List<Comment> commentList = cservice.selectAllFreeComment();
		model.addAttribute("commentList", commentList);
		return "/board/freeBoard";
	}
	
	@RequestMapping(value = "/qna")
	public String showQnAList(Model model) {
		model.addAttribute("addComment", new Comment());
		List<Comment> commentList = cservice.selectAllQnAComment();
		model.addAttribute("commentList", commentList);
		return "/board/qnaBoard";
	}
}
