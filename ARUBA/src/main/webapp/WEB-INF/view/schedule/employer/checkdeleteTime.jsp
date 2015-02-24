<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function() {
	$("#delete").click(function(){
		<c:url value="/deleteTimeTable" var="deleteTimeTable"></c:url>
		var url = "${deleteTimeTable}";
		location.href = url;		
	});
	$("#cancel").click(function(){
		self.close();
	});
});

</script>
</head>
<body>
DB의 모든 시간표를 삭제하시겠습니까?
<button id = "delete">삭제</button>
<button id = "cancel">취소</button>
</body>
</html>