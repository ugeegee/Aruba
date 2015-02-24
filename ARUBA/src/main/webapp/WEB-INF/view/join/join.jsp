<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html lang="en">
<head>

<style>
#user_grade label.error {
	display: none;
	margin-left: 103px;
}

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

<!--------------------- DatePicker --------------------->

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

<script>
	$(document).ready(function() {
		var dp = {
				changeMonth : true,
				changeYear : true,
				yearRange : "1930:2015"
			};
			$("#datepicker").datepicker(dp);
		
		$("#popUpBtn").click(function(){
			/* alert("팝업창이 나올 것!!"); */
					var url = "<%=request.getContextPath()%>/checkIdPopUp"; 
					<%-- var url = "<%=request.getContextPath() %>/checkId?userId="+$("#userId").val(); --%>
					window.open(url, "_blank", "width=500, height=550, toolbar=no, menubar=no, resizable=no");
		});

		$("#joinForm").validate({
			//validation이 끝난 이후의 submit 직전 추가 작업할 부분
			/* submitHandler : function() {
				var f = confirm("글을 등록하시겠습니까?");
				if (f) {
					return true;
				} else {
					return false;
				}
			}, */
			ignore: "",
			//규칙
			rules : {
				/* userId : {
					required : true,
					minlength : 2,
					maxlength : 20
				}, */
				buttonCheck : {
					required : true
				},
				password : {
					required : true,
					minlength : 3,
					maxlength : 20
				},
				password2 : {
					required : true,
					minlength : 3,
					maxlength : 20,
					equalTo : "#password"
				},
				userName : {
					required : true,
					minlength : 1,
					maxlength : 3
				},
				tel : {
					minlength: 10, 
					maxlength: 12, 
					digits : true 
				},
				email : {
					required : true,
					minlength : 2,
					maxlength : 30,
					email : true
				},
				birth : {
					required : true,
					minlength : 9,
					maxlength : 10
				},
				question : {
					required : true,
					minlength : 2, 
					maxlength : 18
				},
				answer : {
					required : true,
					minlength : 1,
					maxlength : 6
				}
			},
			//규칙체크 실패시 출력될 메시지
			messages : {
				/* userId : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				}, */
				buttonCheck : {
					required : "아이디 중복체크는 필수입니다."
				},
				password : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				},
				password2 : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다",
					equalTo : "비밀번호가 불일치합니다"
				},
				userName : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				},
				tel : {
					minlength: "휴대전화 번호는 10자 이상이어야 합니다.", 
					maxlength: "휴대전화 번호는 12자 미만이어야 합니다.", 
					digits : "휴대전화 번호는 숫자만 입력해주세요."
				},
				email : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다",
					email : "메일 기재 규칙에 어긋납니다."
				},
				birth : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다",
					date : "생년월일 기재 규칙에 어긋납니다."
				},
				 grade : {
					required : "필수 입력사항 입니다.",
				}, 
				question : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				},
				answer : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				}
			}
		});

		var joinForm = $("#joinForm");
		for ( var item in joinForm) {
			console.log(item + " : " + joinForm[item]);
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

					<!-- 로그인 버튼 -->
					<c:url value="/login" var="url"></c:url>
					<li><a href="${url }">Log In</a></li>

					<!-- 회원가입 버튼 -->
					<c:url value="/join" var="url"></c:url>
					<li><a href="${url }">Sign Up</a></li>

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
					<h1>Sign Up</h1>
					<p>회원가입</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">Home</li>
						<li>Sign Up</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="signUp" class="container">
 		<c:url value="/join" var="url" />
        <form class="center" role="form" id="joinForm" method="post" action="${url }">
            <fieldset class="registration-form">
            	<div class="form-group">
            		* 아이디를 생성하시려면, 중복확인 버튼을 눌러주세요
            	</div>
                <div class="form-group">
                    <input type="text" id="formId" name="formId" disabled class="form-control">
                    <input type="hidden" name="userId" id="userId" value="" />
                    <br>
                    <input type="button" id="popUpBtn" value="중복 확인" class="btn btn-success btn-md"/><br>
                    <input type="hidden" name="buttonCheck" id="buttonCheck" value="" />
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder="password" class="form-control">
                </div>
                <div class="form-group">
                    <input type="password" id="password2" name="password2" placeholder="password(again)" class="form-control">
                </div>
                <div class="form-group">
                    <input type="text" id="userName" name="userName" placeholder="name" class="form-control">
                </div>
                <div class="form-group">
                    <input type="text" id="tel" name="tel" placeholder="H.P" class="form-control">
                </div>
                <div class="form-group">
                    <input type="text" id="email" name="email" placeholder="e-mail" class="form-control">
                </div>
                 <div class="form-group">
                    <input type="text" id="datepicker" name="birth" placeholder="birthdate" class="form-control">
                </div>
                <div class="form-group">
                	* 사장과 직원 여부를 선택해주세요.
                </div>
                <div class="form-group">
                    <input type="radio" id="grade_employer" value="사장" name="grade" class="form-control" required>사장
                    <input type="radio" id="grade_employer" value="직원" name="grade" class="form-control" >직원<br>
               		<label for="grade" class="error"></label>
                </div>
                <div class="form-group">
                    <input type="text" id="question" name="question" placeholder="question to find your password" class="form-control" size="30">
                </div>
                 <div class="form-group">
                    <input type="text" id="answer" name="answer" placeholder="your answer" class="form-control">
                </div>
                <div class="form-group">
                	<br>
                    <button class="btn btn-success btn-md  btn-block">Sign Up</button>
                </div>
            </fieldset>
        </form>
    </section>

			
		

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
