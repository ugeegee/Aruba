<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>

<style>
#container, #sliders {
	min-width: 310px; 
	max-width: 800px;
	margin: 0 auto;
}
		
#container {
	height: 400px; 
}	
</style>

<meta charset="utf-8">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<!--------------------- HightCharts --------------------->

<script src="chartlib/highcharts.js"></script>
<script src="chartlib/highcharts-3d.js"></script>
<script src="chartlib/exporting.js"></script>

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
		alert("Job1누름");
		alert("c0 = "+c0);
		companyCode = c0;
		var url = "<%=request.getContextPath()%>/selectChart?companyCode="+c0;
		$(location).attr('href',url);
	});
	$('#Job2').click(function(){
		alert("Job2누름");
		alert("c1 = "+c1);
		companyCode = c1;
		var url = "<%=request.getContextPath()%>/selectChart?companyCode="+c1;
		$(location).attr('href',url);
	});
	$('#Job3').click(function(){
		alert("Job3누름");
		alert("c2 = "+c2);
		companyCode = c2;
		var url = "<%=request.getContextPath()%>/selectChart?companyCode="+c2;
		$(location).attr('href',url);
	});
	
	
	
	var seriesData = new Array();			// Series에 저장할 내용 name, data
	var tempArr = new Array();				// 직원별 저장할 임시 Data 배열.
	var dataArr = new Array();				// series에 저장할 Data 배열.
	var name = new Array();					// 직원 이름 저장할 배열.
	var count = 0;							// 배열의 Count.
	var outArr = new Array();				// Json을 저장할 배열.
	var nameArr = new Array();				// Json에서 이름만 추출하여 저장할 배열.
	var Xcategorie = new Array();			// categorie의 x축 이름.
	//$('#chartBtn').on('click',function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/ajaxChart?companyCode=<%=request.getAttribute("nowCode")%>",   
           type:'POST',
           success:function(data){
              //alert("확인 데이터 : " + data);

			var jobj = JSON.parse(data);   
			var e = jobj["charts"];
			$(e).each(function(index, item){
				var inArr = new Array();
                inArr.push(item.month);					// x 축 결정...!
                inArr.push(item.count);					// y 축 결정....!
                inArr.push(item.memberId);
                outArr.push(inArr);
			});
                //차트를 뿌리는 코드.
			console.log("------------OutArr-------------");
			console.log("OutArr : " + outArr);
            for(var i in outArr) {
            	console.log(i + " , " + outArr[i][0]);
                nameArr.push(outArr[i][2]);
			}
            console.log("------------nameArr-------------");
            for(var j in nameArr) {
            	console.log(j + " , " + nameArr[j]);
            }
			/* series 만들기....  */
			name.push(nameArr[0]);			// 첫 이름 저장.
			//alert(name);
			for (var a in outArr) {
            	// 이름 저장...!
				if(name[count] == outArr[a][2]) {
                	console.log("if : " + a);
                 	tempArr.push(outArr[a][1]);
                } else if (name[count] != outArr[a][2]){
                	console.log("a : " + a);
                	dataArr.push(tempArr);
                	seriesData.push({name:name[count], data:dataArr[count]});
                	tempArr = new Array();
                 	tempArr.push(outArr[a][1]);
                	count++;
                	name.push(outArr[a][2]);
                }
			}
			dataArr.push(tempArr);
        	seriesData.push({name:name[count], data:dataArr[count]});
			console.log("------------seriesData-------------");
			console.log("seriesData : " + seriesData);
			/* categories의 x축 설정. */
			Xcategorie.push(outArr[0][0]);		// 초기값 설정.
			for (var idx in outArr) {
				if(Xcategorie != outArr[idx][0]) {
					Xcategorie.push(outArr[idx][0]);							
				}
			}
			//$('#container').highcharts({
			$(function () {
				var chart = new Highcharts.Chart({
				chart: {
					/* backgroundColor: {
				    	linearGradient: { x1: 0, y1: 0, x2: 1, y2: 1 },
				    	stops: [
				   			[0, '#2a2a2b'],
							[1, '#3e3e40']
						]
				    }, */
				    style: {
				    	fontFamily: "Malgun Gothic"
				    },
				    plotBorderColor: '#606063',
				   	renderTo: 'container',
					type: 'column',
					margin: 75,
					options3d: {
						enabled: true,
				    	alpha: 15,
				    	beta: 15,
				    	depth: 50,
				    	viewDistance: 25		    
					},		       
				},
				title: {
	                text: '나의 월급 관리',
	                style : {
	                	color: 'gray'
	                }
	            },
				subtitle: {
					text: 'ARUBA Program.....! By.MALSIKIZIMA'
				},
				xAxis: {
					//type: 'category',
					categories: Xcategorie
				},
				yAxis: {
					min: 0,
					labels: {
						formatter: function() {
							return this.value;
						}
					},
                    title: {
						text: '금액'
					},
					stackLabels: {
						enabled: true,
						style: {
							fontWeight: 'bold',
							color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'                    
						}
					}
				},
				legend: {
					//enabled: false <-- 원래 이것만 있었음...!
		            align: 'right',
		            x: -70,
		            verticalAlign: 'top',
		            y: 20,
		            floating: true,
		            backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
		            borderColor: '#CCC',
		            borderWidth: 1,
		            shadow: false
				},
				tooltip: {
					//pointFormat: '{series.name}: <b>{point.y:.1f}원 </b>',
		            formatter: function () {
		                return '<b>' + this.x + '</b><br/>' +
		                    this.series.name + ': ' + this.y + '<br/>' +
		                    'Total: ' + this.point.stackTotal;
		            }
				},
		        plotOptions: {
		            column: {
		                stacking: 'normal',
		                dataLabels: {
		                    enabled: true,
		                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
		                    style: {
		                        textShadow: '0 0 3px black, 0 0 3px black'
		                    }
		                }
		            }
		        },
				series: seriesData
					});
	
				/* 알파 베타 각도로 그래프를 움직일 수 있는 부분 */
				function showValues() {
			        $('#R0-value').html(chart.options.chart.options3d.alpha);
			        $('#R1-value').html(chart.options.chart.options3d.beta);
			    }
				 $('#R0').on('change', function () {
				 	chart.options.chart.options3d.alpha = this.value;
					showValues();
				 	chart.redraw(false);
				 });
				 $('#R1').on('change', function () {
				 	chart.options.chart.options3d.beta = this.value;
				 	showValues();
				 	chart.redraw(false);
				 });
				 showValues();
				});
   			 }
    	});
    //});
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
					<h1>My Wage</h1>
					<p>나의 월급</p>
				</div>
				<div class="col-sm-6">
					<ul class="breadcrumb pull-right">
						<li class="active">My Job</li>
						<li class="active">My Wage</li>
						<li><a id="Job1">Job1</a></li>
						<li><a id="Job2">Job2</a></li>
						<li><a id="Job3">Job3</a></li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<!--/#title-->
<!-- 직원의 월급관리<br> -->
 	<section id="MyJob" class="container">
	<br>

	<br>
	<!-- 각도조절 바 -->
	<%-- <c:if test="${!empty Times }"> --%>
	<c:if test="${nowCode != -1 }">
	<!-- 그래프 -->
	<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
	<div id="sliders">
		<table>
			<tr><td>Alpha Angle</td><td><input id="R0" type="range" min="0" max="45" value="15"/> <span id="R0-value" class="value"></span></td></tr>
		    <tr><td>Beta Angle</td><td><input id="R1" type="range" min="0" max="45" value="15"/> <span id="R1-value" class="value"></span></td></tr>
		</table>
	</div>
	</c:if>
	<%-- <c:if test="${empty Times }"> --%>
	<c:if test="${nowCode == -1 }">
		<h2>등록된 시간표가 없습니다.</h2>
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
