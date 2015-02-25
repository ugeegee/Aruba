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
		alert("없는 회사정보 입니다.");
	}
	
	$("#addJobForm").validate({
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
			companyCode : {
				required : true,
				minlength : 1,
				digits : true
			},
			companyTel : {
				required : true,
				minlength : 9,
				maxlength : 12,
				digits : true
			}
		},
		//규칙체크 실패시 출력될 메시지
		messages : {
			companyCode : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				digits : "회사코드는 숫자만 입력해주세요."
			},
			companyTel : {
				required : "필수 입력사항 입니다.",
				minlength : "최소 {0}글자이상이어야 합니다",
				maxlength : "최대 {0}글자이하이어야 합니다",
				digits : "전화번호는 숫자만 입력해주세요."
			}
		}
	});

	var addJobForm = $("#addJobForm");
	for ( var item in addJobForm) {
		console.log(item + " : " + addJobForm[item]);
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

						<!-- MY JOB 버튼 -->
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
					<h1>My Job</h1>
					<p>나의 아르바이트</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">My Job</li>
						<li>My Job</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

 	
 	
 	
 	<section id="MyJob" class="container">
 	
 	<c:if test="${emptyCompany =='YES' }">
 	<div class="pad">
		<div id="pricing-table">
	 	<div class="smallbox">
	 	<div class="panel panel-default">
		<div class="panel-heading center"><h4><b>Register Your Job</b></h4></div>
		<div class="panel-body">
		<div class="white">
			<c:url value="/sendMsgToOwner" var="url"></c:url>
				<form id="addJobForm" method="post" action="${url }">
				<table class="table table-striped table-hover">
				<tbody>
					<tr>
						<th class="center"><label>회사코드</label></th>
						<td class="center"><input type="text" name="companyCode" id="companyCode" value="" class="form-control" placeholder="store code"/></td>
					</tr>
					<tr>
						<th class="center"><label>회사전화번호</label></th>
						<td class="center"><input type="text" name="companyTel" id="companyTel" value="" class="form-control" placeholder="store phonenumber"/></td>
					</tr>
				</tbody>
				</table>
				<div align="center" style="margin-bottom: 10px; margin-top: 30px;">
				<button type="submit" class="btn btn-success btn-md">Register</button>
				<button type="reset" id="cancel" class="btn btn-success btn-md" >Reset</button>
			</div>
			</form>
			</div>
			</div>
	</div>
	</div>
	</div>
	</div>
    </c:if>
 	
 	<c:if test="${emptyCompany =='NO' }">
 		<div class="pad">
		<div id="pricing-table">
	 		<div class="smallbox">
    	                <ul class="plan featured">
        	                <li class="plan-name">

            	                <h4>아르바이트 등록과 신청은 최대 3개까지 가능합니다.<br>
            	                	사장님의 승인을 기다리십시오.</h4>
            	                <br>
            	                
                	        </li>
                	     </ul>
             </div>
         </div>
         </div>
	</c:if>
	<hr>
		<div class="pad">
		<div id="pricing-table">
	 	<div class="smallbox">
	 	<div class="panel panel-default">
		<div class="panel-heading center"><h4><b>My Job List</b></h4></div>
		<div class="panel-body">
		<div class="white">
			<table class="table table-striped table-hover">
				<thead>
				<tr>
					<th class="center">회사코드</th>
					<th class="center">회사명</th>
					<th class="center">전화번호</th>
					<th width="10%"></th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${myCompanies }" var="myCompanies">
					<tr>
						<td class="center">${myCompanies.companyCode}</td>
						<td class="center">${myCompanies.companyName}</td>
						<td class="center">${myCompanies.companyTel}</td>
						<td>
							<c:url value="/deleteJob?companyCode=${myCompanies.companyCode}" var="url" /> 
							<a href="${url }"><button class="btn btn-success btn-md">삭제</button></a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
			</div>
	</div>
	</div>
	</div>
	</div>
		
 	 	<%-- <c:if test="${emptyCompany =='YES' }">
 			직장등록
				<c:url value="/sendMsgToOwner" var="url"></c:url>
				<form id="addJobForm" method="post" action="${url }">

					<table class="table" style="border-collapse: seperate;">
						<colgroup>
							<col style="align: center;" />
						</colgroup>
						<tbody>
							<tr>
								<th><label>회사코드</label></th>
								<td><input type="text" name="companyCode" id="companyCode"
									value="" /></td>
							</tr>
							<tr>
								<th><label>회사전화번호</label></th>
								<td><input type="text" name="companyTel" id="companyTel"
									value="" /></td>
							</tr>

						</tbody>
					</table>
					<div align="center" style="margin-bottom: 50px; margin-top: 30px;">
						<button type="submit">등록</button>
						<button type="reset" id="cancel">취소</button>
					</div>
				</form>
			</c:if> 
			<c:if test="${emptyCompany =='NO' }">
				<h2>아르바이트 등록은 최대 3개까지 가능합니다.</h2>
			</c:if>
			<br>
			<br>
 			<h2>직원 직장정보</h2>

			<table class="temp">
				<tr>
					<th>회사코드</th>
					<th>회사명</th>
					<th>전화번호</th>
				</tr>

				<c:forEach items="${myCompanies }" var="myCompanies">

					<tr>
						<td>${myCompanies.companyCode}</td>
						<td>${myCompanies.companyName}</td>
						<td>${myCompanies.companyTel}</td>
					</tr>
				</c:forEach>
			</table> --%>
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
