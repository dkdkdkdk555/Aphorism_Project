<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="include/resource.jsp"></jsp:include>
<meta charset="UTF-8">
<title>home.do</title>
</head>
<body><!-- json 데이터 출력 테스트_2021.04.07 -->
	<c:forEach var="a" items="${list }">
		<h1>${a.id }</h1>
		<div>${a.description }</div>
		<h2>${a.author }</h2>
	</c:forEach>
	
</body>
</html>