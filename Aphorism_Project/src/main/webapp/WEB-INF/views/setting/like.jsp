<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/resource.jsp"></jsp:include>
<meta charset="UTF-8">
<title>like.jsp</title>
<style>
	.container{
		padding-bottom:200px; /* 컨텐츠가 하단탭에 가려지지 않도록 */
		margin-top:20px;
	}
	
	.card-text-E{
		display:none;
	}
	
	.card-subtitle-E{
		display:none;
	}
	
	.card-subtitle-K{
		display:inline;
	}
	
	.trashImg{
		width:22px;
		height:22px;
		position:absolute;
		left: 85%;/* 버튼 위치 */
		
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
		color: #121212;
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
	}
	
	/* 페이지 소개섹션의 타이틀 문구 */
	.title{
		font-family:'Indie Flower', cursive;
		font-weight: bold;
		font-size:24px;
		margin-bottom:10px;
	}
</style>
</head>
<body>
<div>
	<nav class="top_nav">
		<a href="../setting/setting.do"><!-- 이전 페이지 -->
			<span class="material-icons" id="previous">keyboard_backspace</span>
		</a>
	</nav>
	<section class="py-5 text-center container"><!-- 페이지 소개섹션 -->
	    <div class="row py-lg-5">
	      <div class="col-lg-6 col-md-8 mx-auto" id="parentP">
	      <img src="${pageContext.request.contextPath }/resources/svg/heart.svg" class="logimg"/>
			<p class="title" style="padding-left:5px;">My Like</p>
	        <div class="btn-group">
				<button type="button" class="btn btn-outline-secondary" id="en">English mode</button>
				<button type="button" class="btn btn-outline-secondary" id="kr">Korean mode</button>
			</div>
	      </div>
	    </div>
	</section>
</div>
<div class="container"><!-- 데이터 출력부 -->
	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" id="rowum">
		<c:forEach var="tmp" varStatus="l" items="${list }">
			<div class="col">
				<div class="card">
					<div class="card-body">
						<p class="card-text-K">${tmp.descripK }</p>
						<p class="card-subtitle-K">-${tmp.authK }</p>
						<p class="card-text-E">${tmp.descripE }</p>
						<p class="card-subtitle-E">-${tmp.authE }</p>
						<span><!-- 좋아요 삭제 버튼 -->
							<img src="${pageContext.request.contextPath }/resources/svg/trash.svg" class="trashImg" id="${tmp.id }"/>
						</span>
					</div>
				</div>
			</div>
		</c:forEach>
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
	
	//기본언어설정에 따른 효과_2021.04.26
	if(getCookie('isKr')=='yes'){
		$('.title').text('내가 누른 좋아요');
		$('.title').css('font-family',"'Nanum Pen Script', cursive");
	}
	
	//한영버튼_2021.04.24
	$('#en').on('click',function(){
		//버튼 효과
		$(".btn-group").children("button").attr('class', 'btn btn-outline-secondary');//우선 모든 버튼을 outline으로 만듬
		$(this).attr('class', 'btn btn-secondary'); // 그러곤 클릭한 버튼에서 outline제거
		//언어바꿈
		$('.card-text-K').css('display', 'none');
		$('.card-subtitle-K').css('display', 'none');
		$('.card-text-E').css('display', 'block');
		$('.card-subtitle-E').css('display', 'inline');
	});
	$('#kr').on('click',function(){
		//버튼 효과
		$(".btn-group").children("button").attr('class', 'btn btn-outline-secondary');//우선 모든 버튼을 outline으로 만듬
		$(this).attr('class', 'btn btn-secondary'); // 그러곤 클릭한 버튼에서 outline제거
		//언어바꿈
		$('.card-text-E').css('display', 'none');
		$('.card-subtitle-E').css('display', 'none');
		$('.card-text-K').css('display', 'block');
		$('.card-subtitle-K').css('display', 'inline');
	});
	
	
	//쿠키에서 지우기_2021.04.24
	$('.trashImg').on('click',function(){
		let likeId = $(this).attr('id'); // 클릭한 명언의 id가져오기
		//쿠키에서 지우기
		//1.현재 쿠키밸류를 얻어옴
		let currentCookie = getCookie('like');
		//2.현재명언id를 쿠키벨류에서 제거
		futureCookie = currentCookie.replace(likeId, '');
		setCookie('like', futureCookie);
		//3.골뱅이정리
		let reg = /@+/; //@가 하나이상인지 검사하는 정규표현식
		if(reg.test(getCookie('like'))) {
			let newCookie = getCookie('like').replaceAll('@@','@'); // @@는 @로 대체
			setCookie('like', newCookie);
		}
		
		location.reload();//페이지 새로고침
	});
	
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
	
	//쿠키 생성 메소드_2021.04.23
	function setCookie(key, value) {
	    let expiration_date = new Date();
	   	expiration_date.setFullYear(expiration_date.getFullYear()+1);// 시간을 1년으로 지정
	    document.cookie = key + "=" + escape(value) + "; path=/; expires=" + expiration_date.toUTCString();
	}
</script>
</html>