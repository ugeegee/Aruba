<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>

<meta charset="utf-8">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

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

<!--------------------- Full Calendar --------------------->
<link href="lib/fullcalendar.css" rel='stylesheet' />
<!-- <link href='../fullcalendar.print.css' rel='stylesheet' media='print' /> -->
<script src="lib/moment.min.js"></script>
<!-- <script src="lib/jquery.min.js"></script> -->
<script src="lib/jquery-ui.custom.min.js"></script>
<script src="lib/fullcalendar.js"></script>

<script>
<!--------------------- fullCalendar --------------------->
$(document).ready(function() {
	var c = <%=request.getAttribute("nowCode")%>;
	var c0;
	var c1;
	var c2;
	var companyCode = c0;


	if( <%=request.getAttribute("code0")%> == null){
		c0 = -1;
	}else c0 = <%=request.getAttribute("code0")%>;
	if( <%=request.getAttribute("code1")%> == null){
		c1 = -1;
	}else c1 = <%=request.getAttribute("code1")%>;
	if( <%=request.getAttribute("code2")%> == null){
		c2 = -1;
	}else c2 = <%=request.getAttribute("code2")%>;

	
	$('#Job1').click(function(){
		//alert("Job1누름");
		//alert("c0 = "+c0);
		companyCode = c0;
		var url = "<%=request.getContextPath()%>/selectSchedule?companyCode="+c0;
		$(location).attr('href',url);
	});
	$('#Job2').click(function(){
		//alert("Job2누름");
		//alert("c1 = "+c1);
		companyCode = c1;
		var url = "<%=request.getContextPath()%>/selectSchedule?companyCode="+c1;
		$(location).attr('href',url);
	});
	$('#Job3').click(function(){
		//alert("Job3누름");
		//alert("c2 = "+c2);
		companyCode = c2;
		var url = "<%=request.getContextPath()%>/selectSchedule?companyCode="+c2;
		$(location).attr('href',url);
	});
	
	$('#calendar').fullCalendar({	
		// alert("확인");
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		editable: false,
		businessHours: true,
		eventLimit: true, // allow "more" link when too many events
		events: function(start, end, timezone, callback) {
			$.ajax({
				url: "<%=request.getContextPath()%>/display?companyCode=<%=request.getAttribute("nowCode")%>",
				success: function(result) {
					var jobj = JSON.parse(result);
					var e = jobj["event"];
					callback(e);
				}
			});
		}
	});
});

</script>
<style>
#calendar {
	max-width: 900px;
	margin: 0 auto;
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
							<li><a href="<%=request.getContextPath()%>/myJob">My Job</a></li>
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
					<h1>My Shift</h1>
					<p>나의 근무시간표 조회</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li><a id="Job1">Job1</a></li>
						<li><a id="Job2">Job2</a></li>
						<li><a id="Job3">Job3</a></li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="ShowSchedule" class="container">


		<c:if test="${nowCode < 0 }">
			<div class="pad">
			<div id="pricing-table">
	 		<div class="smallbox">
    	                <ul class="plan featured">
        	                <li class="plan-name">
            	                <h5>등록된 직장이 없습니다.</h5>
                	        </li>
                    	</ul>
           	</div>
       		</div>
    		</div>
		</c:if>
		<c:if test="${nowCode > 0 }">
			<div id='calendar'></div>
		</c:if>

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
