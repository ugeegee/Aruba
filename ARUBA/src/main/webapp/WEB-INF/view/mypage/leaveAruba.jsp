<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>

<style>
label.error {
	color: red;
	/* font-style: italic */
}
</style>

<meta charset="utf-8">

<!--------------------- Validate --------------------->
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="lib/jquery.validate.min.js"></script>

<!--------------------- Homepage --------------------->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Services | Flat Theme</title>
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

<!--------------------- DatePicker --------------------->

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

<script>
	$(document).ready(function() {
		
		$("#passForm").validate({
			//validation이 끝난 이후의 submit 직전 추가 작업할 부분
			/* submitHandler : function() {
				var f = confirm("글을 등록하시겠습니까?");
				if (f) {
					return true;
				} else {
					return false;
				}
			}, */
			//규칙
			rules : {
				nowPassword : {
					required : true,
					minlength : 3,
					equalTo : "#password"
				}
			},
			//규칙체크 실패시 출력될 메시지
			messages : {
				nowPassword : {
					required : "필수 입력사항 입니다.",
					minlength :"최소 {0}글자이상이어야 합니다",
					equalTo : "기존 비밀번호와 불일치합니다."
				}
			}
		});

		var passForm = $("#passForm");
		for ( var item in passForm) {
			console.log(item + " : " + passForm[item]);
		}
	});
</script>
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
							data-toggle="dropdown">My Page<i class="icon-angle-down"></i></a>
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
								data-toggle="dropdown">My Store<i class="icon-angle-down"></i></a>
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
								data-toggle="dropdown">Shift Table<i class="icon-angle-down"></i></a>
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
								data-toggle="dropdown">My Job<i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/myJob">My
											Job</a></li>
									<li><a href="<%=request.getContextPath()%>/salary">My
											Wage</a></li>
									<li><a href="<%=request.getContextPath()%>/alert_employee">Alert</a></li>
								</ul></li>

							<!-- 근무표 버튼 -->
							<c:url value="/mySchedule" var="url" />
							<li><a href="${url }">My Table</a></li>

						</c:if>

						<!-- 게시판 버튼 -->
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">Board<i class="icon-angle-down"></i></a>
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
					<h1>Delete Account</h1>
					<p>Pellentesque habitant morbi tristique senectus et netus et
						malesuada</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li><a href="index.html">Home</a></li>
						<li class="active">Services</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="DeleteAccount" class="container">
 		<c:url value="/leaveAruba" var="url" />
        <form:form modelAttribute="addUser" class="center" role="form" id="passForm" method="post" action="${url }">
            <fieldset class="registration-form">
                <div class="form-group">
                    <form:hidden path="userId" id="userId" name="userId" class="form-control"/>
                </div>
                <div class="form-group">
                    <form:hidden path="password" id="password" name="password" class="form-control"/>
                </div>
                <div class="form-group">
                    <input type="password" id="nowPassword" name="nowPassword" placeholder="your password" class="form-control">
                </div>
                <div class="form-group">
                    <button class="btn btn-success btn-md btn-block">leave Aruba</button>
                </div>
            </fieldset>
        </form:form>
    </section>

			
			<div class="row">
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-windows icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Windows Development</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-android icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Android Development</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-apple icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">iOS Development</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
			</div>
			<!--/.row-->
			<div class="gap"></div>
			<div class="row">
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-linux icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Linux Development</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-dribbble icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Graphic Design</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-google-plus icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">SEO Services</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
			</div>
			<!--/.row-->
			<hr>
			<div class="row">
				<div class="col-lg-12">
					<div class="center">
						<h2>What our clients say</h2>
						<p>Pellentesque habitant morbi tristique senectus et netus et
							malesuada fames ac turpis egestas.</p>
					</div>
					<div class="gap"></div>
					<div class="row">
						<div class="col-md-6">
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Integer posuere erat a ante.</p>
								<small>Someone famous in <cite title="Source Title">Source
										Title</cite></small>
							</blockquote>
						</div>
						<div class="col-md-6">
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Integer posuere erat a ante.</p>
								<small>Someone famous in <cite title="Source Title">Source
										Title</cite></small>
							</blockquote>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/#services-->

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
