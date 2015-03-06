<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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

<script type="text/javascript">
	$(document).ready(function() {
		window.$("#useIdBtn").click(function() {
			opener.$("#formId").val("${availableId}");
			opener.$("#userId").val("${availableId}");
			opener.$("#buttonCheck").val("Checked");
			self.close();
		});
		
		$("#inputUserId").validate({
			rules : {
				userId : {
					required : true,
					minlength : 2,
					maxlength : 20
				}
			},
			//규칙체크 실패시 출력될 메시지
			messages : {
				userId : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				}
			}
		});

		var checkIdForm = $("#checkIdForm");
		for ( var item in checkIdForm) {
			console.log(item + " : " + checkIdForm[item]);
		}

	});
</script>

</head>
<style>
label.error {
	color: red;
	/* font-style: italic */
}

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
					<h2>아이디 중복 확인</h2>
					<p>아이디를 사용하시려면 아래에 사용하실 아이디를 입력하고 중복확인을 누르세요.</p>
				</div>
			</div>
		</div>
	</section>
	
	<br>
	<br>
	<c:if test="${result =='First' }">
		<c:url value="/checkId" var="url" />
		<form class="center" role="form" id="inputUserId" action="${url }">
			<fieldset class="registration-form">
				<div class="form-group">
					<input type="text" id="userId" name="userId" placeholder="ID"
						class="form-control">
				</div>
				<div class="form-group">
					<input type="submit" value="중복확인" class="btn btn-success btn-md"/>
				</div>
			</fieldset>
		</form>
	</c:if>
	
	
	<c:if test="${result =='OK' }">
		<fieldset class="registration-form">
			<div class="center">
			<div class="form-group">
				사용가능한 아이디입니다.<br>
				${availableId}로 하시겠습니까?
			</div>
			<div class="form-group">
				<button id="useIdBtn" class="btn btn-success btn-md">사용</button>
			</div>
			</div>
		</fieldset>
		
		<hr>
		
		<c:url value="/checkId" var="url" />
		<form class="center" role="form" id="inputUserId" action="${url }">
			<fieldset class="registration-form">
				<div class="form-group">
					다른 아이디 검색하기
				</div>
				<div class="form-group">
					<input type="text" id="userId" name="userId" placeholder="ID"
						class="form-control">
				</div>
				<div class="form-group">
					<input type="submit" value="중복확인" class="btn btn-success btn-md"/>
				</div>
			</fieldset>
		</form>
	</c:if>


	<c:if test="${result =='NO' }">
		<div class="center">
		<fieldset class="registration-form">
			<div class="form-group">
				${availableId}은 이미 존재하는 아이디입니다.<br>
			</div>
		</fieldset>
		</div>
		<hr>
		<c:url value="/checkId" var="url" />
		<form class="center" role="form" id="inputUserId" action="${url }">
			<fieldset class="registration-form">
				<div class="form-group">
					다른 아이디 검색하기
				</div>
				<div class="form-group">
					<input type="text" id="userId" name="userId" placeholder="ID"
						class="form-control">
				</div>
				<div class="form-group">
					<input type="submit" value="중복확인" class="btn btn-success btn-md btn-block"/>
				</div>
			</fieldset>
		</form>
	</c:if>
	

	

	<!-- <script src="js/jquery.js"></script> -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.prettyPhoto.js"></script>
	<script src="js/main.js"></script>
</body>
</html>





















<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Aruba</title>

<!--------------------- Validate --------------------->
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="lib/jquery.validate.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		window.$("#useIdBtn").click(function() {
			opener.$("#formId").val("${availableId}");
			opener.$("#userId").val("${availableId}");
			opener.$("#buttonCheck").val("Checked");
			self.close();
		});
		
		$("#inputUserId").validate({
			rules : {
				userId : {
					required : true,
					minlength : 2,
					maxlength : 20
				}
			},
			//규칙체크 실패시 출력될 메시지
			messages : {
				userId : {
					required : "필수 입력사항 입니다.",
					minlength : "최소 {0}글자이상이어야 합니다",
					maxlength : "최대 {0}글자이하이어야 합니다"
				}
			}
		});

		var checkIdForm = $("#checkIdForm");
		for ( var item in checkIdForm) {
			console.log(item + " : " + checkIdForm[item]);
		}

	});
</script>

</head>
<style>
label.error {
	color: red;
	/* font-style: italic */
}
</style>
<body>
	<h3>아이디중복확인</h3>
	<br>
	<br>
	<c:if test="${result =='First' }">
		중복확인을 해주세요~<br><br>
		
		<c:url value="/checkId" var="url" />
		<form id="inputUserId" action="${url }">
			<input type="text" name="userId" id="userId" value="" /><br> 
			<input type="submit" value="중복확인">
		</form>
	</c:if>
	
	
	<c:if test="${result =='OK' }">
		${availableId} 사용가능합니다<br><br><br>
		사용하시겠습니까? <button id="useIdBtn">사용</button><br><br>
		
		다시 검색하기<br>
		<c:url value="/checkId" var="url" />
		<form id="inputUserId" action="${url }">
			<input type="text" name="userId" id="userId" value="" /><br> 
			<input type="submit" value="중복확인">
		</form>
	</c:if>


	<c:if test="${result =='NO' }">
		${availableId} 사용불가능합니다<br>

		다시 검색하기<br>
		<c:url value="/checkId" var="url" />
		<form id="inputUserId" action="${url }">
			<input type="text" name="userId" id="userId" value="" /><br> 
			<input type="submit" value="중복확인">
		</form>
	</c:if>




</body>
</html> --%>