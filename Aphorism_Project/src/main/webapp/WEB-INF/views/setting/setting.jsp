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
		
		font-weight: bold;
		font-size:20px;
	}
	
</style>
</head>
<body>
<div class="boss">
	<div class="employee">
		<article id="likes">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/heart.svg" class="logimg"/>
				<p class="title" style="padding-left:5px;" id="like_title">LIKE</p>
			</button>
		</article>
		<article id="language">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/translation.svg" class="logimg"/>
				<p class="title" id="lan_title">KO/EN</p>
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
	<div class="employee" hidden>
		<article id="recommend">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/kakao-talk.svg" class="logimg" style="margin-left:28px;"/>
				<p class="title"  id="recommend_title">Recommend</p>
			</button>
		</article>
		<article id="screen">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/settings.svg" class="logimg" style="margin-left:25px;"/>
				<p class="title" id="screen_title">Run on<br />lock screen</p>
			</button>
		</article>
	</div>
</div>


<jsp:include page="../include/bottom_nav.jsp"></jsp:include>
</body>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>

	//'isKr'한글모드일때  _2021.04.26
	if(getCookie('isKr')=='yes'){
		
		$('.title').css('font-size', '19px');
		
		$('#like_title').text('좋아요');
		$('#like_title').css('padding-left', '');
		
		$('#lan_title').text('한/영');
		$('#lan_title').css('padding-right', '');
		
		$('#color_title').text('배경색');
		$('#color_title').css('padding-left', '');
		
		$('#font_title').text('폰트설정');
		$('#font_title').css('padding-left', '');
		$('#font').find('img').css('margin-left','9px');
		
		$('#recommend_title').text('앱추천하기');
		$('#recommend_title').css('padding-left', '8px');
		$('#recommend').find('img').css('margin-left', '25px');
		
		$('#screen_title').text('잠금화면 앞에 실행');
		$('#screen').find('img').css('margin-left', '55px');
		$('.title').css('font-family',"'Noto Sans KR', sans-serif");
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
	
	//배경색설정효과_2021.04.27
	if(getCookie('theme')!=null) {
		let theme = getCookie('theme');
		if(theme=='original'){
		
		} else if(theme=='dark'){
			//home
			$('.container').css('background','#121212');
			$('.container').css('color','#bbbbbb');
			$('body').css('background','#121212');
			$('body').css('color','#bbbbbb');
			$('button').css('background-color','#121212');
			$('button').css('color','#bbbbbb');
			$('#language').find('img').attr('src', '${pageContext.request.contextPath }/resources/svg/translate_dark.svg');
			//nav
			$('.nav').css('background','#121212');
			$('.nav').css('color','#bbbbbb');
			$('.material-icons-outlined').css('text-color','#bbbbbb');
		} else if(theme=='fa'){
			//home
			$('.container').css('background','#135fa1');
			$('.container').css('color','#ffffff');
			$('body').css('background','#135fa1');
			$('body').css('color','#ffffff');
			$('button').css('background-color','#135fa1');
			$('button').css('color','#ffffff');
			$('#language').find('img').attr('src', '${pageContext.request.contextPath }/resources/svg/translate_dark.svg');
			//nav
			$('.nav').css('background','#1976d2');
			$('.nav').css('color','#ffffff');
		}
	}
	
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
	
	Kakao.init('3b2fce3e5669de0e789ac5e528620099');//카카오에서 발급받은 javascript키로 초기화 한다.
	
	//추천버튼을 누르면_2021.04.24
	$("#recommend").on('click', function(){
		//카카오 피드 메세지 전달 (임시)_2021.04.30
		Kakao.Link.createDefaultButton({
			  container: '#recommend',
			  objectType: 'feed',
			  content: {
			    title: '데일리쿠키',
			    description: '동기부여가 되는 명언 부터 힐링되는 명언까지! 데일리쿠키를 통해 하루를 살아갈 힘을 얻고, 영감을 얻으세요!',
			    imageUrl:
			      'https://ibb.co/ZhXbdqS',
			    link: {
			      mobileWebUrl: 'http://localhost:8888/aphorism/home.do',
			      androidExecParams: 'test',
			    },
			  },
			  social: {
			    likeCount: 10,
			    commentCount: 20,
			    sharedCount: 30,
			  },
			  buttons: [
			    {
			      title: '웹으로 이동',
			      link: {
			        mobileWebUrl: 'http://localhost:8888/aphorism/home.do',
			      },
			    },
			    {
			      title: '앱으로 이동',
			      link: {
			        mobileWebUrl: 'http://localhost:8888/aphorism/home.do',
			      },
			    },
			  ]
			});
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