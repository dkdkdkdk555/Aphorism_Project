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
			<p id="description">${data.descripK }</p>
			<p id="author">${data.authK }</p>
		</div>
		<button class="nav__link" id="language_btn">
			<i class="material-icons nav__icon" id="lan_icon">language</i>
			<span class="material-icons-outlined" id="lan">en</span>
		</button>
		<div class="row-xs-2">
			<button type="button" id="next">
				<i class="material-icons nav__icon">chevron_right</i>
			</button>
		</div>
	</div>
<jsp:include page="include/bottom_nav.jsp"></jsp:include>
</body>
<script>
	//home화면이라면 home메뉴탭을 활성화 시킨다_2021.04.12
	$(document).ready(function(){
		//일단 모든 nav__link--active 활성화 클래스를 제거하고 
		$("#category").removeClass("nav__link--active");
		$("#search").removeClass("nav__link--active");
		$("#setting").removeClass("nav__link--active");
		//탭을 클랙했으니까 해당 클래스에 탭 추가 
		$("#home").addClass("nav__link--active");
	});
	
	//language_btn을 누르면 바로 언어가 바뀌게 하기 위해 담을 변수들
	let desK = null;
	let autK = null;
	let desE = null;
	let autE = null;
	//지금이 영어 모드인지
	let enMode = false;
	
	//language_btn 토글기능 부여_2021.04.13
	$("#language_btn").on("click", function(){
		//버튼 en -> kr
		let lan = $("#lan").text();
		if(lan == "en") {
			$("#lan").text("kr");
			$("#lan_icon").addClass("nav__link--active");
			enMode = true; // en버튼 누르면 텍스트가 kr로바뀌면서 영어모드가됨
			$("#description").text(desE);
			$("#author").text("-"+autE);
		} else {
			$("#lan").text("en"); // kr을 누르면 불빛이 사라지고 텍스트가 en으로 바뀌면서 한글모드가 됨
			$("#lan_icon").removeClass("nav__link--active");
			enMode = false;
			$("#description").text(desK);
			$("#author").text("-"+autK);
		}
	});
	
	//home메뉴 처음 ajax 명언 출력_2021.04.13
	$(document).ready(function(){
		let viewId = $("#id").text();
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId+"&btn=prev",
			method:"GET",
			success:function(data) {
				$("#id").text(""+data["id"]);
				desK = data["descripK"];
				desE = data["descripE"];
				autK = data["authK"];
				autE = data["authE"];
				if(enMode) { //지금이 한글모드이면  
					$("#description").text(""+data["descripE"]);
					$("#author").text("-"+data["authE"]);
				} else { //지금이 영어 모드이면
					$("#description").text(""+data["descripK"]);
					$("#author").text("-"+data["authK"]);
				}
	
			}
		})
	});
	
	//prev버튼 클릭시 앞id의 명언 ajax출력_2021.04.12
	$("#prev").on("click", function(){
		
		let viewId = $("#id").text()-1;
		if(viewId == 0) {
			viewId = ${size};
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId+"&btn=prev",
			method:"GET",
			success:function(data) {
				$("#id").text(""+data["id"]);
				desK = data["descripK"];
				desE = data["descripE"];
				autK = data["authK"];
				autE = data["authE"];
				if(enMode) { //지금이 한글모드이면  
					$("#description").text(""+data["descripE"]);
					$("#author").text("-"+data["authE"]);
				} else { //지금이 영어 모드이면
					$("#description").text(""+data["descripK"]);
					$("#author").text("-"+data["authK"]);
				}
	
			}
		})
	});
	
	//next버튼 클릭시 앞id의 명언 ajax출력_2021.04.12
	$("#next").on("click", function(){
		
		let viewId = parseInt($("#id").text());
		if(viewId == 0 || viewId == ${size}*2) {
			viewId = ${size};
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId +"&btn=next",
			method:"GET",
			success:function(data) {
				$("#id").text(""+data["id"]);
				desK = data["descripK"];
				desE = data["descripE"];
				autK = data["authK"];
				autE = data["authE"];
				if(enMode) { //지금이 한글모드이면 
					$("#description").text(""+data["descripE"]);
					$("#author").text("-"+data["authE"]);
				} else { //지금이 영어 모드이면
					$("#description").text(""+data["descripK"]);
					$("#author").text("-"+data["authK"]);
				}
			}
		})
	});
</script>
</html>