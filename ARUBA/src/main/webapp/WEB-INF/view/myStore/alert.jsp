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

<script>
	
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
					<h1>Alert</h1>
					<p>알림</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">My Store</li>
						<li>Alert</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="AlertControl" class="container">
		<div class="pad">
		<div id="pricing-table">
	 	<div class="smallbox">
	 	<div class="panel panel-default">
		<div class="panel-heading center"><h4><b>messages</b></h4></div>
		<div class="panel-body">
		<div class="white">
			<table class="table table-striped table-hover">
				<thead>
				<tr>
					<th class="center">#</th>
					<th class="center">회사코드</th>
					<th class="center">보낸이</th>
					<th class="center">받는이</th>
					<th class="center">내용</th>
					<th class="center">보낸날짜</th>
					<!-- <th class="center">수신확인</th> -->
					<th class="center">승인버튼</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${myComMessages }" var="myComMessages">

				<tr>
					<td class="center">${myComMessages.messageNumber}</td>
					<td class="center">${myComMessages.companyCode}</td>
					<td class="center">${myComMessages.userId}</td>
					<td class="center">${myComMessages.receiverId}</td>
					<td class="center">${myComMessages.messageContent}</td>
					<td class="center">${myComMessages.regDate}</td>
					<%-- <td class="center">
						${myComMessages.flag }
					</td> --%>
					<td class="center">
						<c:if test="${myComMessages.flag =='0' }">					
							<c:url value="/addNewEmployee?userId=${myComMessages.userId }&companyCode=${myComMessages.companyCode }&messageNumber=${myComMessages.messageNumber }" var="url" /> 
							<a href="${url }"><button class="btn btn-success btn-md">승인</button></a>
							<c:url value="/rejectNewEmployee?userId=${myComMessages.userId }&companyCode=${myComMessages.companyCode }&messageNumber=${myComMessages.messageNumber }" var="url" /> 
							<a href="${url }"><button class="btn btn-success btn-md">거절</button></a>
						</c:if>
						
						<c:if test="${myComMessages.flag =='1' }">	
							<button class="btn btn-success btn-md" disabled>승인</button>
						</c:if>
						<c:if test="${myComMessages.flag =='2' }">	
							<button class="btn btn-success btn-md" disabled>거절</button>
						</c:if>
					
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
	</section>


<%-- 		<table class="temp">
			<tr>
				<th>쪽지번호</th>
				<th>회사코드</th>
				<th>보낸사람</th>
				<th>받는사람</th>
				<th>쪽지내용</th>
				<th>보낸날짜</th>
				<th>읽음여부</th>
				<th>승인버튼</th>
			</tr>

			<c:forEach items="${myComMessages }" var="myComMessages">

				<tr>
					<td>${myComMessages.messageNumber}</td>
					<td>${myComMessages.companyCode}</td>
					<td>${myComMessages.userId}</td>
					<td>${myComMessages.receiverId}</td>
					<td>${myComMessages.messageContent}</td>
					<td>${myComMessages.regDate}</td>
					<td>
						${myComMessages.flag }
					</td>
					<td>
						<c:if test="${myComMessages.flag =='0' }">					
							<c:url value="/addNewEmployee?userId=${myComMessages.userId }&companyCode=${myComMessages.companyCode }&messageNumber=${myComMessages.messageNumber }" var="url" /> 
							<a href="${url }"><button>승인</button></a>	
						<c:url value="/rejectNewEmployee?userId=${myComMessages.userId }&companyCode=${myComMessages.companyCode }&messageNumber=${myComMessages.messageNumber }" var="url"/>
							<a href="${url }"><button>거절</button></a>
						</c:if>
						
						
						<c:if test="${myComMessages.flag =='1' }">	
							<button disabled>승인</button>
							<!-- <button disabled>거절</button> -->
						</c:if>
						
						<c:if test="${myComMessages.flag =='2' }">	
							<!-- <button disabled>승인</button> -->
							<button disabled>거절</button>
						</c:if>
					
					</td>
				</tr>
			</c:forEach>
		</table>
	</section>
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
