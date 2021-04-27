<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>

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
	
	section{/*검색 결과 설명 섹션 설정*/
		margin-top:10px;
		background-color: #cecece;
	}

	.btn{/*한영버튼 크기 설정*/
		font-size: 13px;
	}
	.btn-group{/*한영 버튼 가운데 정렬*/
	 	display:flex;
	 	justify-content:center;
	 	align-item:center;
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
	
	/*상단탭 css*/
	.top_nav{
		top:0;
		display:flex;
		position: fixed;
		width: 100%;
		height:50px;
		padding-top:5px;
		padding-bottom:20px;
		border-bottom: 10px solid #white;
		/*상단탭 가리지 않게 하기 위한 설정*/
		z-index:1; 
		background-color:white;
		justify-content:flex-start;
	}
	/* 검색어 창*/
	#keywordInsert{
		margin-left:5px;
		height: 32px;
		border:none;
		focusable:none;
	}
	/* 검색 버튼 */
	#searchLogo{
		margin-left:20px;
		display:inline;
		flex-grow:1;
		height:20px;
		width:18px;
		
	}
	/* 검색어 창 포커스 되었을 때 설정 */
	input:focus{
		outline:none;
	}
	
	/* placeholder 속성에 대해 */
	::placeholder{
		font-size:0.7rem;
	}
	
	.form{
		display:inline;
	}
	
	#searchResult{ /*검색 결과  표시 */
		size:18px;
		weight:bold;
		color:#595959;
		background-color: #64ffda;
		border:1px solid #64ffda;
		border-radius:15px;
	}
	
	/*임시*/
	.card-text {
		font-family: 'Nanum Pen Script', cursive;
		text-align: center;
	}
	
	.card-subtitle {
		font-family: 'Nanum Pen Script', cursive;
		text-align: center;
	}
</style>
</head>
<body>
<nav class="top_nav">
	<form class="form">
		<img src="${pageContext.request.contextPath }/resources/svg/searchIcon.svg" class="button" type="button" id="searchLogo"/>
		<input class="input" placeholder="Type here to search" id="keywordInsert">
	</form>
</nav>
	<section class="py-5 text-center container"><!-- 검색 결과 설명 섹션 -->
		<p></p>
	    <div class="row py-lg-5">
	      <div class="col-lg-6 col-md-8 mx-auto" id="parentP">
	        <!--검색결과 개수 표시, 폰트 두껍게_짙은 회색_2021.04.21-->
	        <h1 id="searchResult"></h1><br />
	        <div class="btn-group">
				<button type="button" class="btn btn-outline-secondary" id="en">English mode</button>
				<button type="button" class="btn btn-outline-secondary" id="kr">Korean mode</button>
			</div>
	      </div>
	    </div>
  </section>
<div class="container"><!-- 데이터 출력 부 --> 
	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" id="rowum">

	</div>
</div>
<jsp:include page="include/bottom_nav.jsp"></jsp:include><!-- 하단 탭 -->
</body>
<script>
	//search 화면이라면 search메뉴탭을 활성화 시킨다_2021.04.20
	$(document).ready(function(){
		//일단 모든 nav__link--active 활성화 클래스를 제거하고 
		$("#home").removeClass("nav__link--active");
		$("#category").removeClass("nav__link--active");
		$("#setting").removeClass("nav__link--active");
		//탭을 클랙했으니까 해당 클래스에 탭 추가 
		$("#search").addClass("nav__link--active");
		
	});	
	
	//배경색설정효과_2021.04.27
	if(getCookie('theme')!=null) {
		let theme = getCookie('theme');
		if(theme=='original'){
		
		} else if(theme=='dark'){
			//home
			$('.top_nav').css('background','#121212');
			$('.top_nav').children('li').css('color','#bbbbbb');//상단탭 메뉴글자 색
			$('.container').css('background','#121212');
			$('body').css('background','#121212');
			$('section').css('background-color','#808e95');
			//nav
			$('.nav').css('background','#121212');
			$('.nav').css('color','#bbbbbb');
			$('.material-icons-outlined').css('text-color','#bbbbbb');
		} else if(theme=='fa'){
			//home
			$('.container').css('background','#135fa1');
			$('body').css('background','#135fa1');
			$('.top_nav').css('background','#1976d2');
			$('.top_nav').children('li').css('color','#ffffff');//상단탭 메뉴글자 색
			$('.col').css('background','#135fa1');
			$('section').css('background-color','#aed581');
			//nav
			$('.nav').css('background','#1976d2');
			$('.nav').css('text-color','#ffffff');
		}
	}

	
	//'isKr'한글모드일때  _2021.04.26
	if(getCookie('isKr')=='yes'){
		$('.input').attr('placeholder', '검색어를 입력 하세요');
	}
	
	//한영 모드 설정_2021.04.21
	let enMode = false;
	
	let modelSize = 0;//검색 결과 데이터 개수
	
	//검색 결과 데이터를 담아놓을 변수들(한영전환 위해)_2021.04.21
	let descK = [];
	let autK = [];
	let descE = [];
	let autE = [];
	
	$("#en").on("click", function(){
		//버튼 효과
		$(".btn-group").children("button").attr('class', 'btn btn-outline-secondary');//우선 모든 버튼을 outline으로 만듬
		$(this).attr('class', 'btn btn-secondary'); // 그러곤 클릭한 버튼에서 outline제거
		//영어로 바꿈
		enMode = true;
		for(let i=0; i<modelSize; i++) {
			$("#"+i).find('.card-text').text(descE[i]);
			$("#"+i).find('.card-subtitle').text("-"+ autE[i]);
		}
		
	});
	
	$("#kr").on("click", function(){
		//버튼 효과
		$(".btn-group").children("button").attr('class', 'btn btn-outline-secondary');
		$(this).attr('class', 'btn btn-secondary');
		//한글로 바꿈
		enMode = false;
		for(let i=0; i<modelSize; i++) {
			$("#"+i).find('.card-text').text(descK[i]);
			$("#"+i).find('.card-subtitle').text("-"+ autK[i]);
		}
		
	});
	
	//검색버튼을 누르면 input의 텍스트를 가져와 ajax요청을 해서 명언 응답받기_2021.04.20
	$("#searchLogo").on("click", function(){
		//검색창의 텍스트를 가져온다.
		let searchKeyword = $("#keywordInsert").val();
		let reg_en = /^[a-zA-Z]*$/;//영어인지 판별할 정규표현식
		enMode = reg_en.test(searchKeyword); //일치 -> true
		
		//이전에 추가되었던 데이터(태그) 모두 삭제
		$('#rowum').empty(); // 선택한 요소의 자식요소 모두를 삭제한다.(선택한 요소는 삭제되지 않음 (remove(), detach()와의 차이점)
		
		$.ajax({
			url:"${pageContext.request.contextPath }/search_data.do?keyword=" + searchKeyword,
			method:"GET",
			success:function(data){
				modelSize = data.length;
				console.log(data);
				if(data==null || data==undefined || data.length==0){
					$("#searchResult").text("검색결과가 없습니다."); //no result.
				} else {
					$("#searchResult").text("result: "+modelSize); // 총 검색 결과 개수 
				}
				
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
					//한영모드 전환을 위해 배열에다가 데이터 담아둠_21.04.21
					descK[i] = item["descripK"];
					autK[i] = item["authK"];
					descE[i] = item["descripE"];
					autE[i] = item["authE"];
					if(!enMode){ //지금이 영어 모드가 아니라면
						$('#'+i).find('.card-body').append($('<p class="card-text">' + item['descripK'] + '</p>')); // 각 col마다 다른 명언을 넣어야 하기 때문에 
						$('#'+i).find('.card-body').append($('<p class="card-subtitle">' + '-' + item['authK'] + '</p>'));
						
					} else { //지금이 영어 모드이면
						$('#'+i).find('.card-body').append($('<p class="card-text">' + item['descripE'] + '</p>')); 
						$('#'+i).find('.card-body').append($('<p class="card-subtitle">' + '-' + item['authE'] + '</p>'));
						
					}
				
				}
				
				
			}
		})
		
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