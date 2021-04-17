<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<title>category.jsp</title>
<style>
	/*상단탭 css*/
	.top_nav{
		top:0;
		display:flex;
		position: fixed;
		width: 100%;
		height:50px;
		overflow-x:auto; /*기본 스크롤 상태*/
		padding-left:0px;
		padding-right:0px;
		padding-top:10px;
		border-bottom: 5.5px solid #e6e6e6;
		/*상단탭 가리지 않게 하기 위한 설정*/
		z-index:1; 
		background-color:white;
		margin-color:white;
		
	}
	
	/*스크롤 기능은 유지하면서 스크를바는 없애기*/
	.top_nav::-webkit-scrollbar{
		display:none;
	}
	
	/*각각의 카테고리 메뉴 */
	li{
		display:flex;
		flex-grow:1;
		list-style:none;
		padding:0 10px;
		font-family: 'Indie Flower', cursive;
		font-weight: bold;	
	}

	/* 반응형 폰트 크기 설정하는 미디어 쿼리_category탭 버전*/
	@media (max-width:360px){html{font-size:17px;}}
	@media (min-width:360px) and (max-width:799px){html{font-size:18px;}}
	@media (min-width:361px) and (max-width:839px){html{font-size:20px;}}
	@media (min-width:840px) and (max-width:879px){html{font-size:22px;}}
	@media (min-width:880px){html{font-size:24px;}}
	/*반응형 값 보정*/
	@media (min-width:1150px) and (max-width:1220px){ #love{padding-left:30px;}}
	@media (min-width:1221px) and (max-width:1320px){ #love{padding-left:40px;}}
	@media (min-width:1321px) and (max-width:1420px){ #love{padding-left:50px;}}
	@media (min-width:1421px) and (max-width:1500px) { #love{padding-left:60px;}}
	@media (min-width:1521px) and (max-width:1661px) { #love{padding-left:70px;}}
	@media (min-width:1670px){ #love{padding-left:80px;}}
	
	.container{ 
		height:100%; /* 컨텐츠를 가운데 정렬하기 위한 설정*/
		width: 100%;
		display: flex;
		flex-wrap: nowrap;
		align-items:center; /* 컨텐츠를 가운데 정렬하기 위한 설정*/
		align-content:center; /* 컨텐츠를 가운데 정렬하기 위한 설정*/
		flex-direction:column;
		padding-bottom:300px;
		
	}
	
	#rowum{ 
		z-index:0;/*상단탭 가리지 않게 하기 위한 설정*/
		position:relative;
		top:20px;
		
	}
	
	.card{
		border-radius: 15px; /*모서리 둥글게*/
		border: 3.8px solid #e6e6e6;
	}
	
	section{
		background-color: #cecece;
		
	}
	
	/*임시*/
	.card-text {
		font-family: 'Nanum Pen Script', cursive;
	}
	
	.card-subtitle {
		font-family: 'Nanum Pen Script', cursive;
	}
	
	

</style>
</head>
<body>
<jsp:include page="../include/category_tab.jsp"></jsp:include>
	<section class="py-5 text-center container">
	    <div class="row py-lg-5">
	      <div class="col-lg-6 col-md-8 mx-auto">
	        <h1 class="fw-light">Album example</h1>
	        <p class="lead text-muted">Something short and leading about the collection below—its contents</p>
	      </div>
	    </div>
  </section>
<div class="container">
	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" id="rowum">

	</div>
</div>
<jsp:include page="../include/bottom_nav.jsp"></jsp:include>
</body>
<script>
	//category화면이라면 category메뉴탭을 활성화 시킨다_2021.04.16
	$(document).ready(function(){
		//일단 모든 nav__link--active 활성화 클래스를 제거하고 
		$("#home").removeClass("nav__link--active");
		$("#search").removeClass("nav__link--active");
		$("#setting").removeClass("nav__link--active");
		//탭을 클랙했으니까 해당 클래스에 탭 추가 
		$("#category").addClass("nav__link--active");
		
	});	
	
	
	//카테고리 li 선택시 명언데이터 불러오기_2021.04.16 -> 수정 4.17
	$(".top_nav").children("li").on("click", function(){
		//우선 모든 카테고리에 적용된 활성화 효과 지우기
		$('li').css('border-bottom', 'none');
		//클릭한 자식요소 li의 아이디 가져오기
		let id = $(this).attr('id');
		//선택한 카테고리에 활성화 밑줄 효과 주기 
		$("#"+id).css('border-bottom', '3px solid #8080ff');
		//이전에 추가되었던 데이터(태그) 모두 삭제
		$('#rowum').empty(); // 선택한 요소의 자식요소 모두를 삭제한다. (선택한 요소는 삭제되지 않음 (remove(), detach()와의 차이점)
		$.ajax({
			url:"${pageContext.request.contextPath }/category/data_category.do?category=" + id,
			method:"GET",
			success:function(data){
				console.log(data);
				
				for(let i=0; i<data.length; i++) {
					for(let j=0; i<data.length; i++) { //먼저 명언갯수만큼 col를 만들음 
						$('#rowum').append($('<div class="col" id="' + i + '">'+'</div>'));	
					}
					if(!$('.col').find('.card').length) { //.col 하위에 .card 가 존재하지 않는다면 => .length를 쓰는데 있다면 true 리턴, 없다면 false를 리턴
						$('.col').append($('<div class="card">'+'</div>'));		
					}	
					if(!$('.card').find('.card-body').length){
						$('.card').append($('<div class="card-body">'+'</div>'))
					}				
				}
				
				for(let i=0; i<data.length; i++) {
					let item = data[i];
					$('#'+i).find('.card-body').append($('<p class="card-text">' + item['descripK'] + '</p>')); // 각 col마다 다른 명언을 넣어야 하기 때문에 
					$('#'+i).find('.card-body').append($('<p class="card-subtitle">' + '-' + item['authK'] + '</p>'));
				}
			}
		})
	});
</script>
</html>