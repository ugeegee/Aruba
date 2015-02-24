<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<meta charset="utf-8">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<!--------------------- DataTable --------------------->

<script src="//cdn.datatables.net/1.10.5/js/jquery.dataTables.min.js"></script>
<link href="css/dataTables.css" rel="stylesheet">

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
	
	$('#example').DataTable();
	
	/* $("#proceed").click(function(){
		if($("#commentContent").val()==""){
			alert("게시글 내용을 입력해주세요.");
		}else{
			<c:url value="/registerComment" var="comment"></c:url>
			var url = "${comment}?flag=1&commentContent="+$("#commentContent").val();
			location.href = url;
		}
	}); */
});
</script>
<style>
table td,th{
	text-align : center;
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
								<li><a href="<%=request.getContextPath()%>/qna">QnA
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
					<h1>Notice Board</h1>
					<p>공지게시판</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li><a href="index.html">Board</a></li>
						<li class="active">Notice Board</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

<section id="noticeBoard" class="container">
	
		<table id="example" class="table table-striped table-hover" cellspacing="0" width="100%">
   
        <thead>
            <tr>
                <th width="10%" align="center">글번호</th>
                <th>제목</th>
                <th width="20%">작성자</th>
                <th width="20%">작성일</th>
            </tr>
        </thead>
 
        <tfoot>
            <tr>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </tfoot>
 		
        <tbody>
        <c:forEach items="${commentList }" var="commentList">
            <tr>
                <td>${commentList.commentNumber}</td>
                <td>
                	<c:url value="/showReplyList" var="url"></c:url>
					<a href="${url}?no=${commentList.commentNumber}">${commentList.commentContent}</a>
				</td>
				<td>${commentList.userId}</td>
                <td>${commentList.regDate}</td>
            </tr>
         </c:forEach>   
        </tbody>
    </table>
    <br>
	<a href="<%=request.getContextPath()%>/writeComment?flag=1"><button class="btn btn-success btn-md write"><i class="icon-edit-sign"></i> 글쓰기</button></a>
	
    </section>

	
	<section id="bottom" class="wet-asphalt">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-6">
					<h4>About Us</h4>
					<p>Pellentesque habitant morbi tristique senectus et netus et
						malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat
						vitae, ultricies eget, tempor sit amet, ante.</p>
					<p>Pellentesque habitant morbi tristique senectus.</p>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4>Company</h4>
					<div>
						<ul class="arrow">
							<li><a href="#">The Company</a></li>
							<li><a href="#">Our Team</a></li>
							<li><a href="#">Our Partners</a></li>
							<li><a href="#">Our Services</a></li>
							<li><a href="#">Faq</a></li>
							<li><a href="#">Conatct Us</a></li>
							<li><a href="#">Privacy Policy</a></li>
							<li><a href="#">Terms of Use</a></li>
							<li><a href="#">Copyright</a></li>
						</ul>
					</div>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4>Latest Blog</h4>
					<div>
						<div class="media">
							<div class="pull-left">
								<img src="images/blog/thumb1.jpg" alt="">
							</div>
							<div class="media-body">
								<span class="media-heading"><a href="#">Pellentesque
										habitant morbi tristique senectus</a></span> <small class="muted">Posted
									17 Aug 2013</small>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<img src="images/blog/thumb2.jpg" alt="">
							</div>
							<div class="media-body">
								<span class="media-heading"><a href="#">Pellentesque
										habitant morbi tristique senectus</a></span> <small class="muted">Posted
									13 Sep 2013</small>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<img src="images/blog/thumb3.jpg" alt="">
							</div>
							<div class="media-body">
								<span class="media-heading"><a href="#">Pellentesque
										habitant morbi tristique senectus</a></span> <small class="muted">Posted
									11 Jul 2013</small>
							</div>
						</div>
					</div>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4>Address</h4>
					<address>
						<strong>Twitter, Inc.</strong><br> 795 Folsom Ave, Suite 600<br>
						San Francisco, CA 94107<br> <abbr title="Phone">P:</abbr>
						(123) 456-7890
					</address>
					<h4>Newsletter</h4>
					<form role="form">
						<div class="input-group">
							<input type="text" class="form-control" autocomplete="off"
								placeholder="Enter your email"> <span
								class="input-group-btn">
								<button class="btn btn-danger" type="button">Go!</button>
							</span>
						</div>
					</form>
				</div>
				<!--/.col-md-3-->
			</div>
		</div>
	</section>
	<!--/#bottom-->

	<footer id="footer" class="midnight-blue">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					&copy; 2013 <a target="_blank" href="http://shapebootstrap.net/"
						title="Free Twitter Bootstrap WordPress Themes and HTML templates">ShapeBootstrap</a>.
					All Rights Reserved.
				</div>
				<div class="col-sm-6">
					<ul class="pull-right">
						<li><a href="#">Home</a></li>
						<li><a href="#">About Us</a></li>
						<li><a href="#">Faq</a></li>
						<li><a href="#">Contact Us</a></li>
						<li><a id="gototop" class="gototop" href="#"><i
								class="icon-chevron-up"></i></a></li>
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
