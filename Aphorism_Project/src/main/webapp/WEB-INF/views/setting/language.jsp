<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<meta charset="UTF-8">
<title>language.jsp</title>
<style>
	.container{
		padding-bottom:100px; /* 컨텐츠가 하단탭에 가려지지 않도록 */
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
		font-weight: bold;
		font-size:24px;
		margin-bottom:0px;
	}
	
	button{
		border:0; 
		outline:0;
		background-color:#ffffff;
	}
	/* 토글버튼 설정 */
	input { display: none; }
	
	label {
		display:inline-block;
		width: 100px;
		height: 34px;
		cursor: pointer;
		position: relative;
		background-color: #ccc;
	}
	
	label::before{
		content: '';
		display: block;
		width: 26px;
		height:26px;
		left: 4px;
		bottom: 4px;
		position: absolute;
		background-color: #fff;
		transition: all .4s ease;/* 토글 스위치가 스무스하게 움직임 */
	}

	input:checked + label { background-color: #2196F3;}
	input:checked + label:before{
		-webkit-transform:translateX(65px);
		-ms-transform:translateX(65px);
		transform:translateX(65px);
		/* transform : translate(x, y)*/
	}
	
	label.round { border-radius: 34px}
	label.round::before {border-radius: 50%}
	
	/*토글버튼과 p의 레이아웃 조정*/
	.lanInput{
		display:flex;
		justify-content:space-evenly;
		
	}
	
	
</style>
</head>
<body>
<div>
	<nav class="top_nav">
		<a href="../setting/setting.do"><!-- 이전 페이지 -->
			<i class="material-icons" id="previous">keyboard_backspace</i>
		</a>
	</nav>
	<section class="py-5 text-center container"><!-- 페이지 소개섹션 -->
	    <div class="row py-lg-5">
	      <div class="col-lg-6 col-md-8 mx-auto" id="parentP">
	      <img src="${pageContext.request.contextPath }/resources/svg/translation.svg" class="logimg"/>
			<p class="title" style="padding-left:5px;">Basic Language Setting</p>
	      </div>
	    </div>
	</section>
</div>
<div class="container">
	<div class="lanInput">
		<p>Korean basic</p>
		<input type="checkbox" id="lanSwitch" />
		<label for="lanSwitch" class="round"></label>
	</div>
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
	
	//배경색설정효과_2021.04.27
	if(getCookie('theme')!=null) {
		let theme = getCookie('theme');
		if(theme=='original'){
			$('#previous').css('color','#121212');	
		} else if(theme=='dark'){
			//home
			$('.top_nav').css('background','#121212');
			$('.container').css('background','#121212');
			$('body').css('background','#121212');
			$('section').css('background-color','#808e95');
			$('#previous').css('color','#ffffff');
			$('.lanInput').css('color','#ffffff');
			//nav
			$('.nav').css('background','#121212');
			$('.nav').css('color','#bbbbbb');
			$('.material-icons-outlined').css('text-color','#bbbbbb');
		} else if(theme=='fa'){
			//home
			$('.container').css('background','#135fa1');
			$('body').css('background','#135fa1');
			$('.top_nav').css('background','#1976d2');
			$('.col').css('background','#135fa1');
			$('section').css('background-color','#aed581');
			$('#previous').css('color','#ffffff');
			//nav
			$('.nav').css('background','#1976d2');
			$('.nav').css('text-color','#ffffff');
		}
	}
	
	//토글버튼 구현_2021.04.26
	$('#lanSwitch').on('click', function(){ //토글스위치를 누르면
		if($('#lanSwitch').is(':checked')==true){ //눌러서 활성화된 상태로 만들면
			setCookie('isKr', 'yes'); //'isKr'쿠키에 'yes'값이 저장
		} else { // 다시 비활성화 시키며
			setCookie('isKr',''); // 쿠키삭제
		}
		
	});
	
	//'isKr'한글모드일때는 체크박스가 체크되어있는 상태로 나오게 하기 _2021.04.26
	if(getCookie('isKr')=='yes'){
		$('#lanSwitch').prop("checked", true);
		$('.title').text('기본 언어 설정');
		$('.title').css('font-family',"'Nanum Pen Script', cursive");
	}
	
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