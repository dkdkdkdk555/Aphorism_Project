<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="include/resource.jsp"></jsp:include>
<meta charset="UTF-8">
<title>home.do</title>
<style>
	button{
		border:0; 
		outline:0;
		background-color:#ffffff;
	}
</style>
</head>
<body>
	<div class="container">
		<div class="row-xs-2">
			<button type="button" id="prev">
				<i class="material-icons nav__icon">chevron_left</i>
			</button>
		</div>
		<div class="row-xs-8">
			<bold id="id">${data.id }</bold>
			<p id="descripK">${data.descripK }</p>
			<p id="authK">-${data.authK }</p>
		</div>
		<div class="row-xs-2">
			<button type="button" id="next">
				<i class="material-icons nav__icon">chevron_right</i>
			</button>
		</div>
	</div>
<jsp:include page="include/bottom_nav.jsp"></jsp:include>
</body>
<script>
	//home화면이라면 home메뉴탭을 활성화 시킨다_2021.4.12
	$(document).ready(function(){
		//일단 모든 nav__link--active 활성화 클래스를 제거하고 
		$("#category").removeClass("nav__link--active");
		$("#search").removeClass("nav__link--active");
		$("#setting").removeClass("nav__link--active");
		//탭을 클랙했으니까 해당 클래스에 탭 추가 
		$("#home").addClass("nav__link--active");
	});
	
	//prev버튼 클릭시 앞id의 명언 ajax출력_2021.04.12
	$("#prev").on("click", function(){
		
		let viewId = $("#id").text()-1;
		if(viewId == 0) {
			viewId = ${size};
		}
		console.log(viewId);
		
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId+"&btn=prev",
			method:"GET",
			success:function(data) {
				console.log(data["descripK"]);
				$("#id").text(""+data["id"]);
				$("#descripK").text(""+data["descripK"]);
				$("#authK").text(""+data["authK"]);
			}
		})
	});
	
	//next버튼 클릭시 앞id의 명언 ajax출력_2021.04.12
	$("#next").on("click", function(){
		
		let viewId = parseInt($("#id").text());
		if(viewId == 0 || viewId == ${size}*2) {
			viewId = ${size};
		}
		console.log(viewId);
		
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId +"&btn=next",
			method:"GET",
			success:function(data) {
				console.log(data["descripK"]);
				$("#id").text(""+data["id"]);
				$("#descripK").text(""+data["descripK"]);
				$("#authK").text(""+data["authK"]);
			}
		})
	});
</script>
</html>