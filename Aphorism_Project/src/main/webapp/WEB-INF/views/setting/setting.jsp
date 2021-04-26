<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../include/resource.jsp"></jsp:include>
<title>setting.jsp</title>
<style>

	html, body{ /*.boss가 하단탭 나머지 부분을 모두 차지하게 하기 위해 우선 설정 */
			height:100%;
			width: 100%;
	}
	
	/* 모든 버튼을 담고 있는 레이아웃 */
	.boss{
		width:100%;
		height:90%;
		display:flex;
		flex-direction:column;
		
	}
	
	/* 두개의 버튼 담고 있는 레이아웃 */
	.employee{
		display:flex;
		width:100%;
		height:100%
	}
	
	/* 하나의 버튼 담고 있는 레이아웃 */
	article{
		width:100%;
		height:100%;
		display:flex;
		justify-content:center;
		align-content:center;
		
	}
	
	/* 버튼 가운데 정렬 */
	button{
		border:0;
		outline:0;
		background-color:white;
		display:flex;
		flex-direction:column;
		justify-content:center;
		align-content:center;
	}
	
	.logimg{
		width:50px;
		height:50px;
	}
	
	.title{
		font-family:'Indie Flower', cursive;
		font-weight: bold;
		font-size:24px;
	}
	
</style>
</head>
<body>
<div class="boss">
	<div class="employee">
		<article id="likes">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/heart.svg" class="logimg"/>
				<p class="title" style="padding-left:10px;" id="like_title">LIKE</p>
			</button>
		</article>
		<article id="language">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/translation.svg" class="logimg"/>
				<p class="title" style="padding-right:10px;"  id="lan_title">KO/EN</p>
			</button>
		</article>	
	</div>
	<div class="employee">
		<article id="backcolor">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/rgb.svg" class="logimg"/>
				<p class="title" style="padding-left:5px;"  id="color_title">Color</p>
			</button>
		</article>
		<article id="font">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/italic.svg" class="logimg"/>
				<p class="title" style="padding-left:5px;" id="font_title">Font</p>
			</button>
		</article>
	</div>
	<div class="employee">
		<article id="recommend">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/kakao-talk.svg" class="logimg" style="margin-left:43px;"/>
				<p class="title" style="padding-left:5px;" id="recommend_title">Recommend</p>
			</button>
		</article>
		<article id="screen">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/settings.svg" class="logimg" style="margin-left:30px;"/>
				<p class="title" id="screen_title">Run on<br />lock screen</p>
			</button>
		</article>
	</div>
</div>


<jsp:include page="../include/bottom_nav.jsp"></jsp:include>
</body>
<script>

	//'isKr'한글모드일때  _2021.04.26
	if(getCookie('isKr')=='yes'){
		$('#like_title').text('좋아요');
		$('#lan_title').text('한/영');
		$('#color_title').text('배경색');
		$('#font_title').text('폰트설정');
		$('#recommend_title').text('앱추천하기');
		$('#recommend_title').css('padding-left', '10px');
		$('#recommend').find('img').css('margin-left', '23px');
		$('#screen_title').text('잠금화면 앞에 실행');
		$('#screen').find('img').css('margin-left', '40px');
		$('.title').css('font-family',"'Nanum Pen Script', cursive");
	}
	//setting화면이라면 setting메뉴탭을 활성화 시킨다_2021.04.16
	$(document).ready(function(){
		//일단 모든 nav__link--active 활성화 클래스를 제거하고 
		$("#home").removeClass("nav__link--active");
		$("#search").removeClass("nav__link--active");
		$("#category").removeClass("nav__link--active");
		//탭을 클랙했으니까 해당 클래스에 탭 추가 
		$("#setting").addClass("nav__link--active");
		
	});	
	
	//좋아요 모아보기 페이지로 이동_2021.04.24
	$("#likes").on('click', function(){
		location.href ='${pageContext.request.contextPath }/setting/like.do';
	});
	//언어설정 페이지로 이동_2021.04.24
	$("#language").on('click', function(){
		location.href ='${pageContext.request.contextPath }/setting/language.do';
	});
	//배경설정 페이지로 이동_2021.04.24
	$("#backcolor").on('click', function(){
		location.href ='${pageContext.request.contextPath }/setting/backcolor.do';
	});
	//폰트설정 페이지로 이동_2021.04.24
	$("#font").on('click', function(){
		location.href ='${pageContext.request.contextPath }/setting/font.do';
	});
	//추천버튼을 누르면_2021.04.24
	$("#recommend").on('click', function(){
		
	});
	//잠금화면 앞에서 실행 설정 버튼 누르면_2021.04.24
	$("#screen").on('click', function(){
		location.href ='${pageContext.request.contextPath }/setting/screen.do';
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
</script>
</html>