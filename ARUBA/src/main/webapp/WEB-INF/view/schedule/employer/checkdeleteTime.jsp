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
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function() {
	$("#delete").click(function(){
		<c:url value="/deleteTimeTable" var="deleteTimeTable"></c:url>
		var url = "${deleteTimeTable}";
		/* opener.$("#hidden").val("delete"); */
		opener.location.href = url;	
		window.close();
	});
	$("#cancel").click(function(){
		self.close();
	});
});

</script>

<style>
.checkid{
	padding-top:0px;
	text-align: center;
}

.emerald2{
	background-color: #272B30;
	padding: 20px 0;
	color: #fff;
}
</style>
</head>
<body class="checkid">
	<section id="title" class="emerald2">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<h2>Initialize Shift</h2>
					<p>근무표의 모든 스케쥴을 삭제하시겠습니까?</p>
				</div>
			</div>
		</div>
		<div align="center" style="margin-bottom: 40px; margin-top:20px">
			<button id = "delete" class="btn btn-danger btn-md">Yes</button>
			<input type = "hidden" id = "hidden" class = "hidden">
			<button id = "cancel" class="btn btn-danger btn-md" >No</button>
		</div>
	</section>


</body>
</html>