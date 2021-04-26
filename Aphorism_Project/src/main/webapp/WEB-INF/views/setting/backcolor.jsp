<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<meta charset="UTF-8">
<title>backcolor.jsp</title>
<style>
	.container{
		padding-bottom:200px; /* 컨텐츠가 하단탭에 가려지지 않도록 */
		margin-top:20px;
	}

	/*상단탭 css*/
	.top_nav{
		top:0;
		display:flex;
		position: fixed;
		width: 100%;
		height:35px;
		height:50px;
		padding-top:10px;
		/*상단탭 가리지 않게 하기 위한 설정*/
		z-index:1; 
		background-color:white;
		justify-content:flex-start;
	}
	
	/* 뒤로가기 버튼 */
	#previous{
		margin-left:20px;
		display:inline;
		flex-grow:1;
		height:24px;
		width:24px;
	}
	
	/* 페이지 소개섹션 */
	section{
		background-color:#cecece;
		padding-left
	}
	
	/* 페이지 소개섹션의 타이틀 이미지 */
	.logimg{
		width:50px;
		height:50px;
		margin-top:20px;
		margin-bottom:10px;
	}
	
	/* 페이지 소개섹션의 타이틀 문구 */
	.title{
		font-family:'Indie Flower', cursive;
		font-weight: bold;
		font-size:24px;
		margin-bottom:0px;
	}

	
	#dark{
		background-color:#121212;
		color:#bbbbbb;
	}
	
	#fa{
		background-color:#135fa1;
		color:#ffffff;
	}
	
	
	#li_dark > img{
		color:#ffffff;
	}
	

</style>
</head>
<body>
<div>
	<nav class="top_nav">
		<a href="../setting/setting.do"><!-- 이전 페이지 -->
			<img src="${pageContext.request.contextPath }/resources/svg/previous.svg" class="button" type="button" id="previous"/>
		</a>
	</nav>
	<section class="py-5 text-center container"><!-- 페이지 소개섹션 -->
	    <div class="row py-lg-5">
	      <div class="col-lg-6 col-md-8 mx-auto" id="parentP">
	      <img src="${pageContext.request.contextPath }/resources/svg/rgb.svg" class="logimg"/>
			<p class="title" style="padding-left:5px;">background theme setting</p>
	      </div>
	    </div>
	</section>
</div>
<div class="container">
	<ul class="list-group">
	  <li class="list-group-item" id="original">Original
	  	<span class="material-icons" class="check">done</span>
	  </li>
	  <li class="list-group-item" id="dark" >Dark Mode
	  	<span class="material-icons" class="check">done</span>
	  </li>
	  <li class="list-group-item" id="fa">#135fa1
	  	<span class="material-icons" class="check">done</span>
	  </li>
	</ul>
</div>
<div></div>
<jsp:include page="../include/bottom_nav.jsp"></jsp:include>
</body>
<script>
	//setting화면이라면 setting메뉴탭을 활성화 시킨다_2021.04.24
	$(document).ready(function(){
	
		//일단 모든 nav__link--active 활성화 클래스를 제거하고 
		$("#home").removeClass("nav__link--active");
		$("#search").removeClass("nav__link--active");
		$("#category").removeClass("nav__link--active");
		//탭을 클랙했으니까 해당 클래스에 탭 추가 
		$("#setting").addClass("nav__link--active");
	});	
	
	if(getCookie('theme')==null) { // 안먹힘,,
		setCookie('theme', 'original');
		$('#original').children('.check').text('done');
	}
	
	//리스트 선택시 리스너_2021.04.26
	$('.list-group').children('li').on("click",function(){
		// id 읽어오기
		let id = $(this).attr('id');
		//쿠키설정
		setCookie('theme', id);
		//선택했다고 체크해주기
		$('.check').text('');
		$(this).children('.check').text('done'); // 안먹힘,,
	});
	
	//쿠키 생성 메소드_2021.04.23
	function setCookie(key, value) {
	    let expiration_date = new Date();
	   	expiration_date.setFullYear(expiration_date.getFullYear()+1);// 시간을 1년으로 지정
	    document.cookie = key + "=" + escape(value) + "; path=/; expires=" + expiration_date.toUTCString();
	}
	
	
	//쿠키 가져오는 메소드_2021.04.23
	function getCookie(key) {
		let result = null;
		let cookie = document.cookie.split(';');// 쿠키 문자열을 ';'를 기준으로 나누고 배열을 리턴 
	    cookie.some(function(item){ // cookie 배열을 가지고 some의 테스트 함수를 실행시켜 하나의 엘리먼트라도 true면은 true를 리턴하는 메소드 .some() (근데 여기선 걍 배열 요소들 가지고 함수 실행만)
	      
	        item = item.replace(' ', '');// 공백을 제거
	 
	        let dic = item.split('=');// 각 인덱스를 '='기준으로 또 나눔
	 
	        if (key === dic[0]) { // = 의 좌측이 전달받은 key 와 같다면
	            result = dic[1]; // 결과로 value를 담고 (쿠키값 얻어내기)
	            return true;    // getCookie메소드를 종료
	        }
	    });
	    return result; //키값과 일치하는 쿠키가 없다면 null을 리턴
	}
	
</script>
</html>