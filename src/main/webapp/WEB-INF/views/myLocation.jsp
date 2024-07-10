<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by freehtml5.co" />
	<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	<meta name="author" content="freehtml5.co" />
	
<!-- 페북 및 인스타 로고 -->
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>


	<link href="https://fonts.googleapis.com/css?family=Inconsolata:400,700" rel="stylesheet">


<!-- Facebook and Twitter integration -->
	<meta name="twitter:card" content="" />


	<!-- Animate.css -->
	<link rel="stylesheet" href="resources/css/animate.css">
	<!-- <link href="<c:url value="/css/animate.css"/>" rel="stylesheet">-->
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="resources/css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="resources/css/bootstrap.css">
	<!-- Flexslider  -->
	<link rel="stylesheet" href="resources/css/flexslider.css">
	<!-- Theme style  -->
	<link rel="stylesheet" href="resources/css/style.css?after">
	<!-- Modernizr JS -->
	<script src="resources/js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	
<title>천안시 열지도 프로젝트</title>
<style type="text/css">
          .img_wrap {
              width: 400px;
              margin-top: 50px;
          }
          .img_wrap img {
              max-width: 100%;
          }
   
      </style>
</head>
<body>
	<%
		// 메인페이지 jsp -> 세션을 통해 id를 받아서 누가로그인 한지 확인
		String id = null;
		String mtype = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
			mtype = (String)session.getAttribute("mtype");
		}
	%>



	<div id="page">
<div class="fh5co-loader"></div>
	<nav class="fh5co-nav" role="navigation">
		<div class="top-menu">
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<div id="fh5co-logo"><a href="/heatmap/"> 천안시 열지도<span>.</span></a><br><h4>&nbsp;&nbsp;CHEONANSI &nbsp; HEAT MAP</h4></div>
					</div>
					<div class="col-md-8 text-right menu-1">
						<ul>
							<li><a href="/heatmap/">소개</a></li>
							<li><a href="/heatmap/mapCheck">열지도 보기</a></li>
							<!-- if자리 -->
							 <%
			  	if(id == null){ //미로그인시
			  %>
			  
							
								<li  class="active"><a href="/heatmap/Login">열지도 만들기</a></li>
									<li><a href="/heatmap/join">회원가입</a></li>
									
									
								
									
									<li class="btn-cta"><a href="/heatmap/Login"><span>로그인</span></a></li>
									
								
								
								
							
													
				 <%
			  	} else{ //로그인 및 회원가입으로 인하여 로그인 된 경우
			  		if(mtype.equals("admin")){ //관리자가 로그인한 경우
			  	%>
			  	
			  	<li class="has-dropdown">
								<a>열지도 만들기</a>
								<ul class="dropdown">
									<li  class="active"><a href="/heatmap/myLocation">측정자료 올리기</a></li>
									
									<li><a href="/heatmap/result">전체 측정 기록</a></li>      <!-- 관리자가 전체 측정보는곳 -->
      								<li><a href="/heatmap/logout">로그아웃</a></li>
								</ul>
							</li>
							
							<li class="has-dropdown">
								<a>내 정보</a>
								<ul class="dropdown">
								<li><a href="/heatmap/logout">로그아웃</a></li>
  					<li><a href="/heatmap/ChangePassword">비밀번호 변경</a></li>
      				<li><a href="/heatmap/memberDelete">탈퇴하기</a></li>
  							</ul>
							</li>
			  	
			  	
			  	
			  	  <%	
			  	} else{//회원이 로그인한 경우
			  %>
			  
			    	<li class="has-dropdown">
								<a>열지도 만들기</a>
								<ul class="dropdown">
									<li  class="active"><a href="/heatmap/myLocation">측정자료 올리기</a></li>
									<li><a href="/heatmap/myList">나의 측정 기록</a></li>
									      
      								<li><a href="/heatmap/logout">로그아웃</a></li>
								</ul>
							</li>
							<li class="has-dropdown">
								<a>내 정보</a>
								<ul class="dropdown">
								<li><a href="/heatmap/logout">로그아웃</a></li>
  					<li><a href="/heatmap/ChangePassword">비밀번호 변경</a></li>
      				<li><a href="/heatmap/memberDelete">탈퇴하기</a></li>
  							</ul>
							</li>
			   <%	
			  	} 
			  	}
			  %>
			  
			   
			  
						</ul>
					</div>
				</div>
				
			</div>
		</div>
	</nav>
	
	<!-- 윗부분은 상단 바 담당 -->
	
	
	
	
<div class="container">
<div class="jumbotron jumbotron-fluid">
<form method="post" action=myLocation enctype="multipart/form-data">
	<div id="map" style="width:100%;height:350px;"></div> <!-- 지도 출력 -->
	<input type="text" id="latitude" name="latitude" hidden>
	<input type="text" id="longitude" name="longitude" hidden>
	<input type="text" id="MyAddress" name="MyAddress" hidden>
    <br><br>
	<input type="submit" class="btn btn-primary form-control" value="다음">
</form>
</div>

 

</div>


<div class="row copyright">
	<div id="fh5co-started2">
		<div class="overlay"></div>
		<div class="container">
			<div class="row animate-box">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
					<p>
					<br>
						<small class="block"> 충남 천안시 서북구 개목5길 30 2층 (31140)<br></small> 
						<small class="block">TEL : 041)578-9897~8<br></small>
						<small class="block">E-mail : gragenda9897@daum.net<br></small>
						<small class="block">후원 농협 467-01-236533 천안녹색소비자연대<br></small>
						</p>
						<p>
            <a href="https://www.facebook.com/chgcn"><i class="fab fa-facebook"></i></a>
            <a href=https://www.instagram.com/green_9897/><i class="fab fa-instagram"></i></a>
          
					</p>
				</div>
			</div>
		</div>
	</div>
	</div>


</div>

 
 
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e27ccf00f1a03975beba4aef431af12b&libraries=services"></script>
		<script>
											
											var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
											    mapOption = { 
											        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 천안시로 변경해야함
											        draggable: false, // 지도 고정
											        level: 3 // 지도의 확대 레벨 
											    }; 
											var MyAddress="address";
											//var message = "";
											var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
											//주소,좌표 함수?
											var geocoder = new kakao.maps.services.Geocoder();
											
											// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
											if (navigator.geolocation) {

											    navigator.geolocation.getCurrentPosition(function(position) {

													var coord = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);
													//var coord = new kakao.maps.LatLng(37.56496830314491, 126.93990862062978);
													
													var callback = function(result, status) {
													    if (status === kakao.maps.services.Status.OK) {
													    	//console.log(result[0].road_address.address_name);
													    	//!!result[0].road_address ? document.getElementById("MyAddress").value = result[0].address.address_name : 
													    	document.getElementById("MyAddress").value = result[0].address.address_name;

												            //document.getElementById("MyAddress").value = MyAddress;
												            //MyAddress += result[0].road_address.address_name;
												            //console.log(MyAddress);
													    	//if(MyAddress=="address")
													    	//{
													    	//	document.getElementById("MyAddress").value = result[0].address.address_name;
													    	//}else
													    	//{
													    	//	document.getElementById("MyAddress").value = result[0].road_address.address_name;
													    	//}
													    	//document.getElementById("MyAddress").value = result[0].address.address_name;
													    }
													};
													geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
												    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
											        var lat = position.coords.latitude, // 위도
											            lon = position.coords.longitude; // 경도
											        //var lat = 33.450701, // 위도
											        //    lon = 126.570667; // 경도
											            document.getElementById("latitude").value = lat;
											            document.getElementById("longitude").value = lon;
											            	
											        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
											            message = '<div style="padding:5px;">'+'위도 : '+lat+'<br>'+'경도 : '+lon+'</div>'; // 인포윈도우에 표시될 내용입니다
											        	//message = '위도 : '+lat+'<br>'+'경도 : '+lon+'</div>';
											        // 마커와 인포윈도우를 표시합니다
											        displayMarker(locPosition, message);
											            
											      });
											    
											} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
											    
											    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
											        message = 'geolocation을 사용할수 없어요..'
												       	var lat = 0.0, // 위도
											            lon = 0.0; // 경도
											            document.getElementById("latitude").value = lat;
											            document.getElementById("longitude").value = lon;
											    displayMarker(locPosition, message);
											}

											// 지도에 마커와 인포윈도우를 표시하는 함수입니다
											function displayMarker(locPosition, message) {

											    // 마커를 생성합니다
											    var marker = new kakao.maps.Marker({  
											        map: map, 
											        position: locPosition
											    }); 
											    
											    var iwContent = '<div style="padding: 5px 0 0 10px;margin-right: 5px;width: 286px;height: 75px;">'+message+'</div>', // 인포윈도우에 표시할 내용
											        iwRemoveable = true;

											    // 인포윈도우를 생성합니다
											    var infowindow = new kakao.maps.InfoWindow({
											        content : iwContent,
											        removable : iwRemoveable
											    });
											    
											    // 인포윈도우를 마커위에 표시합니다 
											    //infowindow.open(map, marker);
											    
											    // 지도 중심좌표를 접속위치로 변경합니다
											    map.setCenter(locPosition);      
											}
											
											</script>
											
											<!-- jQuery -->
	<script src="resources/js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="resources/js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="resources/js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="resources/js/jquery.waypoints.min.js"></script>
	<!-- Flexslider -->
	<script src="resources/js/jquery.flexslider-min.js"></script>
	<!-- Main -->
	<script src="resources/js/main.js"></script>
<!--<script src="https://code.jquery.com/jquery-3.1.1,min.js"></script>
<srcipt scr="js/bootstrap.js"></srcipt>-->

</body>
</html>