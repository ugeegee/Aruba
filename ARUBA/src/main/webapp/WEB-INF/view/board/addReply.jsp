<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta charset="utf-8">

<!--------------------- Validate --------------------->
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="lib/jquery.validate.min.js"></script>

<!--------------------- Homepage --------------------->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Aruba</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">
	
<script type="text/javascript">
$(document).ready(function() {
	
	var loginId = "<%=request.getAttribute("loginId")%>";
	var adminId = "admin";
	
	$("#deleteBtn").click(function(){
		var id = $("#writeId").html();
		var no = $("#writeNo").html();
		if(id == loginId || adminId == loginId){
			/* alert("자신이쓴글입니다!! "+no); */
			var url = "<%=request.getContextPath()%>/deleteComment?commentNumber="+no;
			$(location).attr('href',url); 
		}else{
			alert("본인이 작성한 글만 삭제할 수 있습니다.");
		}
	});
	$("#modifyBtn").click(function(){
		var id = $("#writeId").html();
		var no = $("#writeNo").html();
		if(id == loginId){
			/* alert("자신이쓴글입니다!! "+no); */
			var url = "<%=request.getContextPath()%>/modifyComment?commentNumber="+no;
			$(location).attr('href',url); 
		}else{
			alert("본인이 작성한 글만 수정할 수 있습니다.");
		}
	});
	$(".ttt").click(function(){
		var btnId = $(this).attr("id");
		/* alert(btnId); */
		
		var idId = "#ReplyId"+btnId;
		var noId = "#ReplyNo"+btnId;
		var commentNo = $("#writeNo").html();
		/* alert("댓글단아이디"+$(idId).html());
		alert("댓글번호"+$(noId).html()); */
		
		
		if($(idId).html() == loginId || adminId == loginId){
			/* alert("댓글이 삭제됩니다."); */
			var url = "<%=request.getContextPath()%>/deleteReply?replyNumber="+$(noId).html()+"&commentNumber="+commentNo;
			$(location).attr('href',url);
		}else{
			alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
		} 
	});
	
	$("#replyForm").validate({
		ignore: "",
		//규칙
		rules : {
			replyContent: {
				required : true,
				minlength : 1,
				maxlength : 30
			}
		},
		//규칙체크 실패시 출력될 메시지
		messages : {
			replyContent : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				maxlength : "최대 {0}글자이하이어야 합니다"
			}
		}
	});

	var replyForm = $("#replyForm");
	for ( var item in replyForm) {
		console.log(item + " : " + replyForm[item]);
	}
});
</script>
<style>
table th{
	text-align : center;
}
label.error {
	color: red;
	/* font-style: italic */
}
</style>
</head>
<body>
	<header class="navbar navbar-inverse navbar-fixed-top wet-asphalt"
		role="banner">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html"><img
					src="images/logo.png" alt="logo"></a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">


					<li><a class="active" class="active"
						href="<%=request.getContextPath()%>/index">Home</a></li>

					<!-- 비로그인 경우 -->
					<c:if test="${empty addUser }">

						<!-- 로그인 버튼 -->
						<c:url value="/login" var="url"></c:url>
						<li><a href="${url }">Log In</a></li>

						<!-- 회원가입 버튼 -->
						<c:url value="/join" var="url"></c:url>
						<li><a href="${url }">Sign Up</a></li>

					</c:if>


					<!-- 로그인 경우 -->
					<c:if test="${!empty addUser }">
						<!-- MY PAGE 버튼 -->
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">My Page <i class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath()%>/myInfo">Modify
										Account</a></li>
								<li><a href="<%=request.getContextPath()%>/modifyPass">Change
										Password</a></li>
								<li><a href="<%=request.getContextPath()%>/leaveAruba">Delete
										Account</a></li>
							</ul></li>

						<!-- 사장인 경우 -->
						<c:if test="${addUser.grade=='사장' }">
							<!-- 로그아웃 버튼 -->
							<c:url value="/logout" var="url" />
							<li><a href="${url }">Log Out</a></li>

							<!-- MY PAGE 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">My Store <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/myCompany">Store
											Control</a></li>
									<li><a href="<%=request.getContextPath()%>/staff">Staff
											Control</a></li>
									<li><a href="<%=request.getContextPath()%>/wage">Wage
											Control</a></li>
									<li><a href="<%=request.getContextPath()%>/alert_employer">Alert</a></li>
								</ul></li>

							<!-- 근무표 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Shift Table <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a
										href="<%=request.getContextPath()%>/registerSchedule">Register
											Shift</a></li>
									<li><a href="<%=request.getContextPath()%>/modifySchedule">Modify
											Shift</a></li>
									<li><a href="<%=request.getContextPath()%>/allSchedule">Show
											Shift</a></li>
								</ul></li>

						</c:if>

						<!-- 직원인 경우 -->
						<c:if test="${addUser.grade=='직원' }">
							<!-- 로그아웃 버튼 -->
							<c:url value="/logout" var="url" />
							<li><a href="${url }">Log Out</a></li>

							<!-- MY PAGE 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">My Job <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/myJob">My
											Job</a></li>
									<li><a href="<%=request.getContextPath()%>/salary">My
											Wage</a></li>
									<li><a href="<%=request.getContextPath()%>/alert_employee">Alert</a></li>
								</ul></li>

							<!-- 근무표 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Shift Table <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<c:url value="/mySchedule" var="url" />
									<li><a href="${url }">My Shift</a></li>
								</ul>
							</li>

						</c:if>

						<!-- 게시판 버튼 -->
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">Board <i class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath()%>/notice">Notice
										Board</a></li>
								<li><a href="<%=request.getContextPath()%>/free">Free
										Board</a></li>
								<li><a href="<%=request.getContextPath()%>/qna">Q&A
										Board</a></li>
							</ul></li>
					</c:if>


					<c:url value="/contact" var="url"></c:url>
					<li><a href="${url }">Contact</a></li>
				</ul>
			</div>
		</div>
	</header>
	<!--/header-->

	<section id="title" class="emerald">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<c:if test="${selectedComment.flag=='1' }">
						<h1>Notice Board</h1>
						<p>공지게시판</p>
					</c:if>
					<c:if test="${selectedComment.flag=='2' }">
						<h1>Free Board</h1>
						<p>자유게시판</p>
					</c:if>
					<c:if test="${selectedComment.flag=='3' }">
						<h1>Q&A Board</h1>
						<p>Q&A 게시판</p>
					</c:if>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
					<c:if test="${nowFlag=='1' }">
						<li class="active">Board</li>
						<li>Notice Board</li>
					</c:if>
					<c:if test="${nowFlag=='2' }">
						<li class="active">Board</li>
						<li>Free Board</li>
					</c:if>
					<c:if test="${nowFlag=='3' }">
						<li class="active">Board</li>
						<li>Q&A Board</li>
					</c:if>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->
	
	
	
	
 	<section id="freeBoard" class="container">
 		<div id="comment-form">
			<div class="panel panel-default">
  				<div class="panel-heading">
  					<table class="new">
  						<tr><td width="3%">글번호 │ </td><td width="10%" id="writeNo">${selectedComment.commentNumber}</td>
  							<td width="3%">작성자 │ </td><td width="10%" id="writeId">${selectedComment.userId}</td>
  							<td width="3%">작성일 │ </td><td width="10%"> ${selectedComment.regDate}</td>
  						</tr>
  					</table>
  				</div>
  				<div class="panel-heading">
  					제목 │ <strong>${selectedComment.commentTitle}</strong>
  				</div>
  				<div class="panel-body">
  					<!-- 글내용 -->
  					<div class="boardcontent">
  						<br>
  						${selectedComment.commentContent}
  						<br><br><br>
  						<div align="right" style="margin-bottom: 10px;">
							<button id="modifyBtn" class="btn btn-success btn-sm"><i class="icon-edit-sign"></i> Modify Posting</button>
							<button id="deleteBtn" class="btn btn-success btn-sm"><i class="icon-edit-sign"></i> Delete Posting</button>
						</div>
					</div>	
					<hr>
					
					<!-- 댓글내용 -->
					<div class="replycontent">
					<c:forEach items="${replyList }" var="replyList">
  						<div class="media">
                        	<div class="pull-left">
                            	<img class="avatar img-circle" src="images/blog/avatar3.png" alt="">
                            </div>
                            <div class="media-body">
                            <div class="well">
                            	<div class="media-heading">
                            		<div id="ReplyNottt${replyList.replyNumber}" hidden>${replyList.replyNumber}</div>
                                	<strong id="ReplyIdttt${replyList.replyNumber}">${replyList.userId}</strong>&nbsp; 
                                	<small>${replyList.regDate }</small>
                                </div>
                                <p>${replyList.replyContent}</p>
                                <div align="right" >
                                	<button id="ttt${replyList.replyNumber}" class="ttt btn btn-success btn-xs">Delete Comment</button>
                                </div>
                            </div>
                            </div>
                        </div>
					</c:forEach>
					</div>
					
					
					<!-- 댓글쓰는부분 -->
					<div id="comment-form">
                    	<c:url value="/registerReply" var="action"></c:url>
						<form:form modelAttribute="addReply" id="replyForm" method="post" action="${action}"  class="form-horizontal" >
						<form:input type = "hidden" path="commentNumber" value = "${selectedComment.commentNumber}" />
 							<div class="form-group">
                             	<div class="col-sm-12">
                             		<form:input path="replyContent" name="replyContent" class="form-control" placeholder="Leave a comment"/>
                                </div>
                            </div>
                            <div align="right" style="margin-bottom: 10px;">
                            <input type="submit" value="Submit Comment" class="btn btn-success btn-xs"/>
							<input type="reset" value="Reset" class="btn btn-success btn-xs"/>
							</div>
                        </form:form>
                   </div><!--/#comment-form-->
				</div>
				</div>
				</div>


  				<%-- 
  					<c:forEach items="${replyList }" var="replyList">
  						<div class="media">
                        	<div class="pull-left">
                            	<img class="avatar img-circle" src="images/blog/avatar3.png" alt="">
                            </div>
                            <div class="media-body">
                            <div class="well">
                            	<div class="media-heading">
                                	<strong>${replyList.userId}</strong>&nbsp; <small>${replyList.regDate }</small>
                                </div>
                                <p>${replyList.replyContent}</p>
                                <button id="btn${replyList.replyNumber}" class="btn">삭제</button>
                            </div>
                            </div>
                        </div>
					</c:forEach>
					
					
					<!-- 댓글다는부분 -->
					<div id="comment-form">
                    	<c:url value="/registerReply" var="action"></c:url>
						<form:form modelAttribute="addReply" id="replyForm" method="post" action="${action}"  class="form-horizontal" >
						<form:input type = "hidden" path="commentNumber" value = "${selectedComment.commentNumber}" />
 							<div class="form-group">
                             	<div class="col-sm-12">
                             		<form:input path="replyContent" name="replyContent" class="form-control" placeholder="Leave a comment"/>
                                </div>
                            </div>
                            <div align="right" style="margin-bottom: 10px;">
                            <input type="submit" value="Submit Comment" class="btn btn-success btn-xs"/>
							<input type="reset" value="Reset" class="btn btn-success btn-xs"/>
							</div>
                        </form:form>
                   </div><!--/#comment-form-->
								
      			</div>
			</div>
			
			<!-- <div align="right" style="margin-bottom: 10px;">
				<button id="modifyBtn" class="btn btn-success btn-sm"><i class="icon-edit-sign"></i> Modify Posting</button>
				<button id="deleteBtn" class="btn btn-success btn-sm"><i class="icon-edit-sign"></i> Delete Posting</button>
			</div> -->
		</div>  --%>
		
		
		<%-- <table class="temp" width="100%">
				<tr>
					<th width = "10%">글번호</th>
					<th width = "30%">종류?</th>
					<th width = "30%">작성자</th>
					<th>작성날짜</th>
					<th width = "10%">

					</th>
				</tr>
				<tr> 
					<td align = "center" id="writeNo">${selectedComment.commentNumber}</td>
					<td align = "center">
					<c:if test="${selectedComment.flag=='1' }">공지게시판</c:if>
					<c:if test="${selectedComment.flag=='2' }">자유게시판</c:if>
					<c:if test="${selectedComment.flag=='3' }">Q&A게시판</c:if>
					</td>
					<td align = "center" id="writeId">${selectedComment.userId}</td>
					<td align = "center">${selectedComment.regDate}</td>
					<td align = "center">
					<button id="deleteBtn">삭제</button>
					<button id="modifyBtn">수정</button>
					</td>
				</tr>
				<tr>
					<td colspan="5"><strong>${selectedComment.commentTitle}</strong></td>
				</tr>
				<tr>
					<td colspan="5">${selectedComment.commentContent}</td>
				</tr>
			</table>
			<br><br><br><hr> 
			
			<table class="temp" width="100%">
					<tr>
						<th width = "10%">댓글번호</th>
						<th>댓글내용</th>
						<th width = "15%">아이디</th>
						<th width = "20%">작성날짜</th>
						<th width = "10%"></th>
					</tr>
				<c:forEach items="${replyList }" var="replyList">
					<tr> 
						<td align = "center" id="ReplyNottt${replyList.replyNumber}">${replyList.replyNumber}</td>
						<td>${replyList.replyContent}</td>
						<td align = "center" id="ReplyIdttt${replyList.replyNumber}">${replyList.userId}</td>
						<td align = "center">${replyList.regDate }</td>
						<td align = "center"><button id="ttt${replyList.replyNumber}" class="ttt">삭제</button></td>
					</tr>
				</c:forEach>
			</table>		
					<hr>
		<c:url value="/registerReply" var="action"></c:url>
			<form:form modelAttribute="addReply" id="replyForm" method="post" action="${action}">
				<table>
					<tr>
						<form:input type = "hidden" path="commentNumber" value = "${selectedComment.commentNumber}" />
					</tr>
				</table><br>
				<form:input path="replyContent" name="replyContent" class="form-control" placeholder="댓글 쓰기"/>
 				<br>
 				<input type="submit" value="댓글등록"/>
				<input type="reset" value="다시쓰기"/>
			</form:form> --%>
    </section>
	




	 
		<%-- 	<table class="temp" width="100%">
				<tr>
					<th width = "10%">글번호</th>
					<th width = "30%">종류?</th>
					<th width = "30%">작성자</th>
					<th>작성날짜</th>
					<th width = "10%">

					</th>
				</tr>
				<tr> 
					<td align = "center" id="writeNo">${selectedComment.commentNumber}</td>
					<td align = "center">
					<c:if test="${selectedComment.flag=='1' }">공지게시판</c:if>
					<c:if test="${selectedComment.flag=='2' }">자유게시판</c:if>
					<c:if test="${selectedComment.flag=='3' }">Q&A게시판</c:if>
					</td>
					<td align = "center" id="writeId">${selectedComment.userId}</td>
					<td align = "center">${selectedComment.regDate}</td>
					<td align = "center">
					<button id="deleteBtn">삭제</button>
					<button id="modifyBtn">수정</button>
					</td>
				</tr>
				<tr>
					<td colspan="5"><strong>${selectedComment.commentTitle}</strong></td>
				</tr>
				<tr>
					<td colspan="5">${selectedComment.commentContent}</td>
				</tr>
			</table>
			<br><br><br><hr> 
			
			<table class="temp" width="100%">
					<tr>
						<th width = "10%">댓글번호</th>
						<th>댓글내용</th>
						<th width = "15%">아이디</th>
						<th width = "20%">작성날짜</th>
						<th width = "10%"></th>
					</tr>
				<c:forEach items="${replyList }" var="replyList">
					<tr> 
						<td align = "center" id="ReplyNobtn${replyList.replyNumber}">${replyList.replyNumber}</td>
						<td>${replyList.replyContent}</td>
						<td align = "center" id="ReplyIdbtn${replyList.replyNumber}">${replyList.userId}</td>
						<td align = "center">${replyList.regDate }</td>
						<td align = "center"><button id="btn${replyList.replyNumber}" class="btn">삭제</button></td>
					</tr>
				</c:forEach>
			</table>		
					<hr>
		<c:url value="/registerReply" var="action"></c:url>
			<form:form modelAttribute="addReply" id="replyForm" method="post" action="${action}">
				<table>
					<tr>
						<form:input type = "hidden" path="commentNumber" value = "${selectedComment.commentNumber}" />
					</tr>
				</table><br>
				<form:input path="replyContent" name="replyContent" class="form-control" placeholder="댓글 쓰기"/>
 				<br>
 				<input type="submit" value="댓글등록"/>
				<input type="reset" value="다시쓰기"/>
			</form:form>
			
			 --%>



		<section id="bottom" class="wet-asp">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-6">
					<h4><i class="icon-thumbs-up-alt"></i> About Us</h4>
					<p>We are team 'MalSikizimarazo' meaning 'dont talk to me while we are eating' in Korean.</p>
					<p>This team was named under the fact that we have calm and respectful eating etiquette.</p>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4><i class="icon-globe"></i> Project Aruba</h4>
					<div>
						<p>Aruba is a web-project providing efficient shift tables for part time jobs in the world.</p>
						<p>It is easily visiable and understandble for employers to manage all different individual employee's shifts. It presents wage graphs and charts on a frequent time basis.</p>
						<p>Project Aruba would not exist without the support of KoDB.</p>
					</div>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4><i class="icon-lightbulb"></i> Our Service</h4>
					<div>
						<div class="media">
							<div class="pull-left">
								<i class="icon-calendar icon-md"></i>
							</div>
							<div class="media-body">
								<span class="media-heading">Shift Table </span>
								<small class="muted">You can register and modify shift table and see it whenever you want.</small>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<i class="icon-money icon-md"></i>
							</div>
							<div class="media-body">
								<span class="media-heading">Salary Check</span> 
								<small class="muted">Your salary graph is updated on a daily basis.</small>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<i class="icon-edit-sign icon-md"></i>
							</div>
							<div class="media-body">
								<span class="media-heading">Board</span> 
								<small class="muted">It provides two boards depending on necessary.
One is opened to anything to share freely and another is based on qna.</small>
							</div>
						</div>
					</div>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4><i class="icon-building"></i> Address</h4>
					<address>
						<strong>MALSIKIZIMARAZO</strong><br> 
						Sejoing Univ <br>
						Gwangjin-gu, Seoul, South Korea<br> 
						Phone : 010-5096-3002
					</address>
				</div>
				<!--/.col-md-3-->
			</div>
		</div>
	</section>
	<!--/#bottom-->

	<footer id="footer" class="wet-asphalt">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					&copy; 2015 MalSikizimarazo. All Rights Reserved.
				</div>
				<div class="col-sm-6">
					<ul class="pull-right">
						<li><a id="gototop" class="gototop" href="#"><i
								class="icon-circle-arrow-up icon-2x"></i></a></li>
						<!--#gototop-->
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<!--/#footer-->

	<!-- <script src="js/jquery.js"></script> -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.prettyPhoto.js"></script>
	<script src="js/main.js"></script>
</body>
</html>
