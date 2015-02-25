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
	function createTimeTable(id, title, start, end) {
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.getInfo = function() {
			return "Id : " + this.id + ", Title : " + this.title + ", Start : "
					+ this.start + ", End : " + this.end;
		}
	}

	$(document).ready(
			function() {
				var start;
				var end;
				var title;
				var id;
				var result = new Array();

				/* initialize the external events
				-----------------------------------------------------------------*/

				$('#external-events .fc-event').each(function() {

					// store data so the calendar knows to render an event upon drop
					$(this).data('event', {
						title : $.trim($(this).text()), // use the element's text as the event title
						stick : true
					// maintain when user navigates (see docs on the renderEvent method)
					});

					// make the event draggable using jQuery UI
					$(this).draggable({
						zIndex : 999,
						revert : true, // will cause the event to go back to its
						revertDuration : 0
					//  original position after the drag
					});

				});

				/* initialize the calendar
				-----------------------------------------------------------------*/

				$('#calendar').fullCalendar({
							header : {
								left : 'prev,next today',
								center : 'title',
								right : 'month,agendaWeek,agendaDay'
							},
							timeFormat : {
								'' : 'HH:mm',
								agenda : 'HH:mm',
							//console.log("agenda" , HH:mm)
							},
							editable : true,
							droppable : true, // this allows things to be dropped onto the calendar
							eventDrop : function(event) {
								id = event._id;
								title = event.title;
								start = event.start.format('YYYY-MM-DD HH:mm:ss');
								console.log("Drop_id : " + id);
								console.log('Drop_title : ', title);
								console.log('Drop_start : ', start);
								//console.log('end111', event.end.toString());	

								if (event.end == null) {
									//alert("뭐지?")
									event.end = event.start.clone();
									event.end.set("hours", event.end.get("hours")+2);
									end = event.end.format('YYYY-MM-DD HH:mm:ss');
									console.log('Drop_end : ', end);
								} else {
									/* event.end.set("hours", event.end.get("hours") + 2); */
									end = event.end.format('YYYY-MM-DD HH:mm:ss');
									console.log('Drop_end : ', end);
								}
								for ( var i in result) {
									if (result[i] != null) {
										if (result[i].id == id) {
											result.splice(i, 1);
											console.log(result);
										}
									}
								}

								var newTemp = new createTimeTable(id, title,
										start, end);
								result.push(newTemp);
								console.log(result);
							},
							/* eventDragStop : function(event, ui) {
							}, */
							eventResize : function(event/* , delta, revertFunc */) {
								title = event.title;
								start = event.start.format('YYYY-MM-DD HH:mm:ss');
								
								end = event.end.format('YYYY-MM-DD HH:mm:ss');
								id = event._id;

								/* ArrayList<timetable> list;
								if () 
								list.add(?); */
								console.log("Resize_id : " + id);
								console.log("Resize_title : " + title);
								console.log("Resize_start : " + start);
								console.log("Resize_End : " + end);

								for ( var i in result) {
									if (result[i] != null) {
										if (result[i].id == id) {
											result.splice(i, 1);
											console.log(result);
										}
									}
								}

								var newTemp = new createTimeTable(id, title,
										start, end);
								result.push(newTemp);
								console.log(result);
							},
							/* eventResizeStop : function(event) {
							}, */
							drop : function(date, ui, jsEvent) {
								console.log(date._d);
							}
						});
				console.log("title : " + title + ", start : " + start
						+ ", End : " + end);

				$("#save").click(function() {
					var objstr = JSON.stringify(result);
					console.log(objstr);
					<c:url value="/addTimeTable" var="addTimeTable"></c:url>
					var url = "${addTimeTable}?list=" + objstr;
					location.href = url;
				})
			});
</script>
<style>

/* 	body {
		margin-top: 40px;
		text-align: center;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
	} */
#wrap {
	width: 1100px;
	margin: 0 auto;
}

#external-events {
	float: left;
	width: 150px;
	padding: 0 10px;
	border: 1px solid #ccc;
	background: #eee;
	text-align: left;
}

#external-events h4 {
	font-size: 16px;
	margin-top: 0;
	padding-top: 1em;
}

#external-events .fc-event {
	margin: 10px 0;
	cursor: pointer;
	/* background-color: navy; */
	/* border: 1px solid white; */
}

#external-events p {
	margin: 1.5em 0;
	font-size: 11px;
	color: #666;
}

#external-events p input {
	margin: 0;
	vertical-align: middle;
}

#calendar {
	float: right;
	width: 900px;
}

/* .fc_event0 {
	background-color:green;
}

.event_1 {
	background-color:blue;
}

.event_2 {
	background-color:yellow;
}

.event_3 {
	background-color:black;
}
 */
.savee{
	float: right;
	width: 16.666666666666664%;
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
					<h1>Register Shift</h1>
					<p>직원 근무시간표 등록</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">Shift Table</li>
						<li>Register Shift</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="registerSchedule" class="container">
		<div id='wrap'>

			<div id='external-events'>
				<h4>My Staffs</h4>
				<!-- <table border = "1"> -->
				<c:forEach items="${employees}" var="employee" varStatus="cur">
					<!-- <tr> -->
					<!-- <td> -->
					<div class = 'fc-event' class='fc-event_${cur.index}'>${employee.userId}</div>
					<!-- </td> -->
					<!-- </tr> -->
				</c:forEach>
				<p>
					<label for = 'drop-remove'>* 직원 아이콘을 달력에 드래그해서 근무시간을 설정하세요. </label>
				</p>
				<!-- </table> -->
				<!-- <p>
					<input type='checkbox' id='drop-remove' /> <label
						for='drop-remove'>remove after drop</label>
				</p> -->
			</div>

			<div id='calendar'></div>
			<br>
			<div style='clear: both'></div>

		</div>
		
			<div align="center" style="margin-bottom: 40px; margin-top:20px">
			<button id="save" class="btn btn-danger btn-lg">Save Shift</button>
		</div>
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
