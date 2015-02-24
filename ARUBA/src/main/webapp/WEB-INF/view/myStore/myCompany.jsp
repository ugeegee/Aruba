<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
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

<script>
$(document).ready(function() {
	
	if(<%=request.getAttribute("PopUp")%> == 1){
		alert("회사정보가 수정됬습니다.");
	}
	
	$("#modifyComForm").validate({
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
			companyName : {
				required : true,
				minlength : 1,
				maxlength : 6
			},
			companyTel : {
				required : true,
				minlength: 9, 
				maxlength: 12, 
				digits : true 
			},

			holidayComm : {
				required : true,
				minlength: 1, 
				maxlength: 3, 
				digits : true 
			},
			nightComm : {
				required : true,
				minlength: 1, 
				maxlength: 3, 
				digits : true 
			},
			nowPass : {
				required : true,
				equalTo : "#ownerPass"
			}
		},
		//규칙체크 실패시 출력될 메시지
		messages : {
			companyName : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				maxlength : "최대 {0}글자이하이어야 합니다"
			},
			companyTel : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				maxlength : "최대 {0}글자이하이어야 합니다",
				digits : "전화번호는 숫자만 입력해주세요."
			},
			
			holidayComm : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				maxlength : "최대 {0}글자이하이어야 합니다",
				digits : "휴일수당은 숫자만 입력해주세요."
			},
			nightComm : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				maxlength : "최대 {0}글자이하이어야 합니다",
				digits : "야근수당은 숫자만 입력해주세요."
			},
			nowPass : {
				required : "필수 입력사항 입니다.",
				equalTo : "비밀번호가 불일치합니다"
			}
		}
	});

	var modifyComForm = $("#modifyComForm");
	for ( var item in modifyComForm) {
		console.log(item + " : " + modifyComForm[item]);
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

					<!-- 로그아웃 버튼 -->
					<c:url value="/logout" var="url" />
					<li><a href="${url }">Log Out</a></li>

					<!-- MY STORE 버튼 -->
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
							<li><a href="<%=request.getContextPath()%>/registerSchedule">Register
									Shift</a></li>
							<li><a href="<%=request.getContextPath()%>/modifySchedule">Modify
									Shift</a></li>
							<li><a href="<%=request.getContextPath()%>/allSchedule">Show
									Shift</a></li>
						</ul></li>


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
					<h1>Store Control</h1>
					<p>회사 관리</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">My Store</li>
						<li>Store Control</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

 	<section id="StoreControl" class="container">
 		<div class="pad">
		<div id="pricing-table">
	 		<div class="smallbox">
    	                <ul class="plan featured">
        	                <li class="plan-name">
            	                <h4>현재 등록된 회사</h4>
            	                <br>
                	        </li>
                    	    <li>
         <c:url value="/modifyMyCom" var="action" />
		<form:form modelAttribute="myCom" mehtod="post" action="${action }" id="modifyComForm">
			<table class="table" style="border-collapse: seperate;">
				<tbody>
					<tr>
						<td><label>회사코드</label></td>
						<td><form:input path="companyCode" name="companyCode" id="companyCode" class="form-control"/></td>
						<td><input type="hidden" name="ownerPass" id="ownerPass" value=${ownerPass} /></td>					
					</tr>
						
					<tr>
						<th class="center"><label>회사명</label></th>
						<td><form:input path="companyName" name="companyName" id="companyName" class="form-control"/></td>
					</tr>
					<tr>
						<th class="center"><label>회사전화번호</label></th>
						<td><form:input path="companyTel" name="companyTel" id="companyTel" class="form-control"/></td>
					</tr>
					<tr>
						<th class="center"><label>주말수당(%)</label></th>
						<td><form:input path="holidayComm" name="holidayComm" id="holidayComm" class="form-control"/></td>
					</tr>
					<tr>
						<th class="center"><label>야근수당(%)</label></th>
						<td> <form:input path="nightComm" name="nightComm" id="nightComm" class="form-control"/></td>
					</tr>
				</tbody>
			</table>
		</form:form> 
			<div align="center" style="margin-bottom: 20px; margin-top: 30px;">
				<input type="submit" class="btn btn-success btn-md" name="modify" value="Modify"/>
				<input type="submit" class="btn btn-success btn-md" name="delete" value="Delete"/>
			</div>
                   	     
        </li>
        </ul>
        </div>
        </div>
    </div>
 	
 	
 	
 	
 		<%-- 
			<table>
			<tr>
				<td><label>Code</label></td>
				<td><form:hidden path="companyCode" name="companyCode" id="companyCode"/></td>
			</tr>
			<tr>
				<td><label>OwnerPass</label></td>
				<td><input type="hidden" name="ownerPass" id="ownerPass" value=${ownerPass} /></td>
			</tr>
			<tr>
			<tr>
				<td><label>회사명</label></td>
				<td><form:input path="companyName" name="companyName" id="companyName"/></td>
			</tr>		
			<tr>
				<td><label>회사전화번호</label></td>
				<td><form:input path="companyTel" name="companyTel" id="companyTel" /></td>
			</tr>
			<tr>
				<td><label>주말수당(%)</label></td>
				<td><form:input path="holidayComm" name="holidayComm" id="holidayComm"/></td>
			</tr>			
			<tr>
				<td><label>야근수당(%)</label></td>
				<td> <form:input path="nightComm" name="nightComm" id="nightComm"/></td>
			</tr>		
			<tr>
				<td><label>비밀번호</label></td>
				<td><input type="text" name="nowPass" id="nowPass" /></td>
			</tr>
				</table>
					<input type="submit" name="modify" value="수정"/>
					<input type="submit" name="delete" value="삭제"/>
			</form:form> --%>
				
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
