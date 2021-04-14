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
	html, body{ /*.container가 하단탭 나머지 부분을 모두 차지하게 하기 위해 우선 설정*/
		height:100%;
		width: 100%;
	}

	button{
		border:0; 
		outline:0;
		background-color:#ffffff;
	}
	
	/* 뷰페이지 레이아웃 구성 */
	.container{ 
		height:84%; /* 컨텐츠를 가운데 정렬하기 위한 설정*/
		width: 100%;
		display: flex;
		flex-wrap: nowrap;
		justify-content:space-between; /* prev, next버튼이 컨텐츠 크기에 따라 위치가 바뀌는 문제 해결 */
		align-items:center; /* 컨텐츠를 가운데 정렬하기 위한 설정*/
		align-content:center; /* 컨텐츠를 가운데 정렬하기 위한 설정*/
		
		
	}
	#prev {
		margin-right: 8px;
		padding-left: 0px;
	}
	#next {
		margin-left: 8px;
		padding-right: 0px;
	}
	.row-xs-8 { /* description 담은 div*/
		margin: 0px 30px
	}
	#author { 
		text-align: center;
	}
	#description {
		text-align: center;
	}
	#language_btn { /* 한영 전환 버튼 */
		padding-left:0px;
	}
	
	/* 반응형 폰트 크기 설정하는 미디어 쿼리*/
	@media (max-width:360px){html{font-size:20px;}}
	
	@media (min-width:360px) and (max-width:799px){html{font-size:21px;}}
	
	@media (min-width:361px) and (max-width:839px){html{font-size:22px;}}
	
	@media (min-width:840px) and (max-width:879px){html{font-size:24px;}}
	
	@media (min-width:880px){html{font-size:28px;}}
	
</style>
</head>
<body>
	<div class="container">
		<div class="row-xs-2"><!-- prev버튼 -->
			<button type="button" id="prev">
				<i class="material-icons nav__icon">chevron_left</i>
			</button>
		</div>
		<div class="row-xs-8"><!--명언출력부-->
			<p id="id"></p>
			<p id="description"></p>
			<p id="author"></p>
			<button class="nav__link" id="language_btn"><!-- 한영전환 버튼 -->
				<i class="material-icons nav__icon" id="lan_icon">language</i>
				<span class="material-icons-outlined" id="lan">en</span>
			</button>
		</div>
		<div class="row-xs-2"><!-- next버튼 -->
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
	//language_btn 시각적으로 토글기능 부여_2021.04.13
	$("#language_btn").on("click", function(){
		//버튼 en -> kr
		let lan = $("#lan").text();
		if(lan == "en") {
			$("#lan").text("kr");
			$("#lan_icon").addClass("nav__link--active");
			enMode = true; // en버튼 누르면 텍스트가 kr로바뀌면서 영어모드가됨
			$("#description").text(desE);
			$("#author").text("-"+autE);
			//영어 일 때는 roboto체로 바꾸기 
			$("#description").css('font-family',"'Indie Flower', cursive");
			$("#author").css('font-family',"'Indie Flower', cursive");
		} else {
			$("#lan").text("en"); // kr을 누르면 불빛이 사라지고 텍스트가 en으로 바뀌면서 한글모드가 됨
			$("#lan_icon").removeClass("nav__link--active");
			enMode = false;
			$("#description").text(desK);
			$("#author").text("-"+autK);
			//한글 일 때는 나눔명조체로 바꾸기 
			$("#description").css('font-family',"'Nanum Pen Script', cursive");
			$("#author").css('font-family',"'Nanum Pen Script', cursive");
		}
	});
	
	//전체 명언의 사이즈
	let size = 0;
	
	//home메뉴 처음 ajax 명언 출력_2021.04.13
	$(document).ready(function(){
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id=0&btn=not",// 맨처음 페이지 로딩할때는 명언을 무작위로 가져오게 하기위해 id=0으로, 
					// 아무버튼도 누르지 않았으니까 btn=not으로 quote.do에 요청한다. 
			method:"GET",
			success:function(data) {
				$("#id").text(""+data["id"]);
				desK = data["descripK"];
				desE = data["descripE"];
				autK = data["authK"];
				autE = data["authE"];
				size = data["size"]; // 총 명언의 갯수 수정
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
		
		let viewId = $("#id").text()-1; //이전 id의 명언을 불러오기위해 전달할 id값
		if(viewId == 0) { //현재 명언의 id가 1이라면 id=0인 명언은 없으니까 전체 명언의 중간을 불러오기
			viewId = parseInt(size/2);
			if(viewId == NaN) {
				viewId +=1;
			}
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId+"&btn=prev",
			method:"GET",
			success:function(data) {
				$("#id").text(""+data["id"]);
				desK = data["descripK"];//한영모드 기능 지원을 위해 전역변수에 값을 담음
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
		if(viewId == size) { //현재명언의 id가  전체 명언의 크기와 같다면 다음 id의 명언이 존재하지 않으니
			viewId = parseInt(size/2); // 명언의 중간부터 보여주기 
			if(viewId == NaN) {
				viewId +=1;
			}
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath }/quote.do?id="+ viewId +"&btn=next",
			method:"GET",
			success:function(data) {
				$("#id").text(""+data["id"]);
				desK = data["descripK"]; //한영모드 기능 지원을 위해 전역변수에 값을 담음
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