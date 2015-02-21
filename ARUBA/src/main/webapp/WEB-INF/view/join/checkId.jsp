<%@ page language="java" contentType="text/html; charset=UTF-8"
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
</html>