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

				$('#calendar').fullCalendar(
						{
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
								/* for(items in event) {
									console.log(items);
								} */
								id = event._id;
								title = event.title;
								start = event.start
										.format('YYYY-MM-DD HH:mm:ss');
								console.log("Drop_id : " + id);
								console.log('Drop_title : ', title);
								console.log('Drop_start : ', start);
								//console.log('end111', event.end.toString());	

								if (event.end == null) {
									event.end = event.start.clone();
									event.end.set("hours", event.end
											.get("hours") + 1);
									end = event.end
											.format('YYYY-MM-DD HH:mm:ss');
									console.log('Drop_end : ', end);
								} else {
									end = event.end
											.format('YYYY-MM-DD HH:mm:ss');
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
							eventDragStop : function(event, ui) {
							},
							eventResize : function(event, delta, revertFunc) {
								title = event.title;
								start = event.start
										.format('YYYY-MM-DD HH:mm:ss');
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
							eventResizeStop : function(event) {
							},
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
	background-color: navy;
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
						data-toggle="dropdown">My Page<i class="icon-angle-down"></i></a>
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
							<li><a href="<%=request.getContextPath()%>/registerSchedule">Register
									Shift</a></li>
							<li><a href="<%=request.getContextPath()%>/modifySchedule">Modify
									Shift</a></li>
							<li><a href="<%=request.getContextPath()%>/allSchedule">Show
									Shift</a></li>
						</ul></li>


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
					<h1>Register Schedule</h1>
					<p>Please input your login information</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li><a href="index.html">Home</a></li>
						<li class="active">Register Schedule</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="registerSchedule" class="container">
		<div id='wrap'>

			<div id='external-events'>
				<h4>Company!</h4>
				<!-- <table border = "1"> -->
				<c:forEach items="${employees}" var="employee">
					<!-- <tr> -->
					<!-- <td> -->
					<div class='fc-event'>${employee.userId}</div>
					<!-- </td> -->
					<!-- </tr> -->
				</c:forEach>
				<!-- </table> -->
				<p>
					<input type='checkbox' id='drop-remove' /> <label
						for='drop-remove'>remove after drop</label>
				</p>
			</div>

			<div id='calendar'></div>
			<br>
			<div style='clear: both'></div>

		</div>
		
		<br>
		<br>
		<div id="save1" class="savee">
			<button id="save" class="btn btn-danger btn-md btn-block">저장</button>
		</div>
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
