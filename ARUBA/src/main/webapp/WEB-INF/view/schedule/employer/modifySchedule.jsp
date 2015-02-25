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
function createTimeTable(id, title, start, end){
	this.id = id;
	this.title = title;
	this.start = start;
	this.end = end;
	this.getInfo = function() {
		return "Id : " + this.id + ", Title : " + this.title + ", Start : " + this.start + ", End : " + this.end;    		
	}
}
$(document).ready(function() {
	var start;
	var end;
	var title;
	var id;
	var results = new Array();
	var updates = new Array();
	var deletes = new Array();
	var outArr = new Array();
	var inArr = new Array();
	var e = new Array();
	

	
	$.ajax({
		url: "<%=request.getContextPath()%>/updateAjax",
		success: function(result) {
			var jobj = JSON.parse(result);
			var e = jobj["event"];
			console.log(e);
			console.log(e[0]);
			//callback(e);
		for (var a in e) {
			outArr.push({title:e[a].title, start:e[a].start, end: e[a].end,color:e[a].color});				
		}
		/* initialize the external events
		-----------------------------------------------------------------*/

		/* $('#external-events .fc-event').each(function() {

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

		}); */
		
		$('#calendar').fullCalendar({
			//defaultDate: '2015-02-12',
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			editable: true,
			businessHours: true,
			eventLimit: true, // allow "more" link when too many events
			events: outArr,
			eventDrop : function(event) {
				/* for(items in event) {
					console.log(items);
				} */
				id = event._id;
				title = event.title;
				start = event.start.format('YYYY-MM-DD HH:mm:ss');
				console.log("Drop_id : " + id);
				console.log('Drop_title : ', title);
				console.log('Drop_start : ', start);
				//console.log('end111', event.end.toString());	
				
				if (event.end == null) {
					event.end = event.start.clone();
					event.end.set("hours", event.end.get("hours")+1);
					end = event.end.format('YYYY-MM-DD HH:mm:ss');
					console.log('Drop_end : ', end);
				} else {
					end = event.end.format('YYYY-MM-DD HH:mm:ss');
					console.log('Drop_end : ', end);
				}
				/* for(var i in results) {
					if(results[i] != null) {
						if(results[i].id == id) {
							results.splice(i, 1);
							console.log(results);
						}
					}					
				} */

				var newTemp = new createTimeTable(id, title, start, end);
				results.push(newTemp);
				console.log(results);
			}, 
			eventDestroy: function(event, element, view)
	        {
	            //alert("removing stuff");
	        },
			eventClick: function(event, element) {
				title = event.title;
				start = event.start.format('YYYY-MM-DD HH:mm:ss');
				end = event.end.format('YYYY-MM-DD HH:mm:ss');
				id = event._id;
				$(this).css('background-color', 'blue');
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					// $(this).remove();
					$('#calendar').fullCalendar('removeEvents', id);
				}
				console.log("Click_id : " + id);
				console.log("Click_title : " + title);
				console.log("Click_start : " + start);
				console.log("Click_End : " + end);	
				
				var deleteid = new createTimeTable(id, title, start, end);
				deletes.push(deleteid);
				console.log(deletes);
			},
			eventDragStart: function(event) {
				title = event.title;
				start = event.start.format('YYYY-MM-DD HH:mm:ss');
				end = event.end.format('YYYY-MM-DD HH:mm:ss');
				id = event._id;
				
				console.log("drag_id : " + id);
				console.log("drag_title : " + title);
				console.log("drag_start : " + start);
				console.log("drag_End : " + end);	
				
				/* for(var i in updates) {
					if(updates[i] != null) {
						if(updates[i].id == id) {
							updates.splice(i, 1);
							console.log(updates);
						}
					}					
				} */
				
				var update = new createTimeTable(id, title, start, end);
				updates.push(update);
				console.log(updates);
			},
			eventResizeStart : function(event, delta, revertFunc) {
				title = event.title;
				start = event.start.format('YYYY-MM-DD HH:mm:ss');
				end = event.end.format('YYYY-MM-DD HH:mm:ss');
				id = event._id;
				
				console.log("RS_id : " + id);
				console.log("RS_title : " + title);
				console.log("RS_start : " + start);
				console.log("RS_End : " + end);	
				
				/* for(var i in updates) {
					if(updates[i] != null) {
						if(updates[i].id == id) {
							updates.splice(i, 1);
							console.log(updates);
						}
					}					
				} */
				
				var update = new createTimeTable(id, title, start, end);
				updates.push(update);
				console.log(updates);
			},
			eventResize : function(event) {
				title = event.title;
				start = event.start.format('YYYY-MM-DD HH:mm:ss');
				end = event.end.format('YYYY-MM-DD HH:mm:ss');
				id = event._id;
				
				/* ArrayList<timetable> list;
				if () 
				list.add(?); */
				console.log("RE_id : " + id);
				console.log("RE_title : " + title);
				console.log("RE_start : " + start);
				console.log("RE_End : " + end);	
				
				/* for(var i in results) {
					if(results[i] != null) {
						if(results[i].id == id) {
							results.splice(i, 1);
							console.log(results);
						}
					}					
				} */
				var newTemp = new createTimeTable(id, title, start, end);
				results.push(newTemp);
				console.log(results);
			}
		});
		}
	});
	
	$("#initbutton").click(function() {
		var url = "<%=request.getContextPath()%>/checkdeleteTime"; 
		window.open(url, "_blank", "width=600, height=200, toolbar=no, menubar=no, resizable=no");
	})
	
	$("#updatebutton").click(function() {
		var updateStart = JSON.stringify(updates);
		var updateEnd = JSON.stringify(results);
		var deleteItem = JSON.stringify(deletes);
		console.log(updates);
		console.log(results);
		console.log(deletes);
		<c:url value="/updateTimeTable" var="updateTimeTable"></c:url>
		var url = "${updateTimeTable}?updateStart=" + updateStart + "&updateEnd=" + updateEnd + "&deleteItem=" + deleteItem;
		location.href = url;
	})
})

</script>
<style>
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
	/* background-color: navy;
	border: 1px solid white; */
	/* color: yellow; event의 글씨 */
}

#external-events p {
	margin: 1.5em 0;
	font-size: 11px;
	color: red;
}

#external-events p input {
	margin: 0;
	vertical-align: middle;
}

#calendar {
	float: right;
	max-width: 900px;
	margin: 0 auto;
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
					<h1>Modify Shift</h1>
					<p>직원 근무시간표 수정</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">Shift Table</li>
						<li>Modify Shift</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->

	<section id="modifySchedule" class="container">
		<div id='wrap'>
				<div id='external-events'>
				<h4>My Staffs</h4>
				<!-- <table border = "1"> -->
				<%-- <c:forEach items="${employees}" var="employee">
					<!-- <tr> -->
					<!-- <td> -->
					<div class='fc-event'>${employee.userId}</div>
					<!-- </td> -->
					<!-- </tr> -->
				</c:forEach> --%>
				<!-- </table> -->
				<p>
					<input type='checkbox' id='drop-remove' /> <label
						for='drop-remove'>remove after click</label>
				</p>
			</div>
	<div id='calendar'></div>
	<br>
			<div style='clear: both'></div>

	</div>
	
	<br>
	<br>
	
	<div align="center" style="margin-bottom: 40px; margin-top:20px">
		<button id="initbutton" class="btn btn-danger btn-lg">Initialize Shift</button>
		<button id="updatebutton" class="btn btn-danger btn-lg">Modify Shift</button>
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
