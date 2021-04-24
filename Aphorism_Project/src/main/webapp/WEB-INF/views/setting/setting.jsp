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
				<p class="title" style="padding-left:10px;">LIKE</p>
			</button>
		</article>
		<article id="language">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/translation.svg" class="logimg"/>
				<p class="title" style="padding-right:10px;">KO/EN</p>
			</button>
		</article>	
	</div>
	<div class="employee">
		<article id="backcolor">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/rgb.svg" class="logimg"/>
				<p class="title" style="padding-left:5px;">Color</p>
			</button>
		</article>
		<article id="font">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/italic.svg" class="logimg"/>
				<p class="title" style="padding-left:5px;">Font</p>
			</button>
		</article>
	</div>
	<div class="employee">
		<article id="recommend">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/kakao-talk.svg" class="logimg" style="margin-left:43px;"/>
				<p class="title" style="padding-left:5px; ">Recommend <br />to friends</p>
			</button>
		</article>
		<article id="screen">
			<button>
				<img src="${pageContext.request.contextPath }/resources/svg/settings.svg" class="logimg" style="margin-left:30px;"/>
				<p class="title" >Run on <br />lock screen</p>
			</button>
		</article>
	</div>
</div>


<jsp:include page="../include/bottom_nav.jsp"></jsp:include>
</body>
<script>
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
</script>
</html>