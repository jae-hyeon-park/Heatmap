<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.PrintWriter"%>
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
        .sidemenu {
            float: right;
        }
</style>
</head>
<body>
   <%
   // 메인페이지 jsp -> 세션을 통해 id를 받아서 누가로그인 한지 확인
   String id = null;
   String mtype = null;
   if (session.getAttribute("id") != null) {
      id = (String) session.getAttribute("id");
      mtype = (String) session.getAttribute("mtype");
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
                           <li><a href="/heatmap/myLocation">측정자료 올리기</a></li>
                           
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
                           <li><a href="/heatmap/myLocation">측정자료 올리기</a></li>
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

         <form method="post" action=surveyformUpload enctype="multipart/form-data">
            ${data.date}<br> 
            <input type="date" name="date" value="${data.date }" hidden> 
            1. 배정번호: [${data.assignmentNum }]<br> 
            <input type="number" id="assignmentNum" name="assignmentNum"
               value="${data.assignmentNum }" hidden> 
            
            2. 이름: [${data.namefull }]<br> <input type="text" id="namefull"
               name="namefull" value="${data.namefull }" hidden> 
            
            3. 측정지: [${data.area1}]<br> 
            <input type="text" id="area1" name="area1" value="${data.area1}" hidden> 
            
            4. 측정 기온: [${data.temperatures }]<br>
            <input type="number" id="temperatures" name="temperatures"
               value="${data.temperatures }" hidden>

            <c:set var="weather" value="${data.weather }" />
            <c:choose>
               <c:when test="${weather eq 'blur' }">5. 기상상태: [흐림]</c:when>
               <c:when test="${weather eq 'sunny' }">5. 기상상태: [맑음]</c:when>
               <c:when test="${weather eq 'rain' }">5. 기상상태: [비]</c:when>
               <c:when test="${weather eq 'snow' }">5. 기상상태: [눈]</c:when>
               <c:otherwise>5. 기상상태: [${data.weather }]</c:otherwise>
            </c:choose>
            <br> 
            <input class="form-check-input" type="text" id="Sunny"
               name="weather" value="${data.weather }" hidden> 
            
            <input class="form-check-input"
               type="text" id="latitude" name="latitude" value="${data.latitude }" hidden> 
            
            <input class="form-check-input" type="text" id="longitude"
               name="longitude" value="${data.longitude }" hidden> 
            
            6. 측정시간: ${data.time }<br> 
            <input type="time" name="time" step="2" value="${data.time }" hidden> 
            
            7. 사진이름: ${data.filename1 }<br>
            <input type="text" name=filename1 value="${data.filename1 }" hidden>

            <div class="img_wrap">
               <img src="data:image/jpg;base64,${data.encfile1 }"
                  alt="${data.filename1 }" width="400" height="400" /><br>

   

            <input type="text" name="encfile1" value="${data.encfile1 }" hidden>
            <br>
            <div id="map" style="width:100%;height:350px;"></div>
            <br>
            <a href="javascript:history.back()" role="button" class="btn btn-primary">뒤로</a> 
            <input type="submit"value="제출" class="btn btn-primary" style="float: right;">
            
         </form>

      </div>

      

</div>

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
         <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e27ccf00f1a03975beba4aef431af12b"></script>
   <script>
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   mapOption = { 
       center: new kakao.maps.LatLng(${data.latitude },${data.longitude }), // 지도의 중심좌표
       draggable: false, // 지도 고정
       level: 5 // 지도의 확대 레벨
   };
   
   var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
   
   // 날씨 데이터를 한글화 합니다
   var weatherTrans ="${data.weather }";
   if(weatherTrans=="blur")weatherTrans="흐림";
   else if(weatherTrans=="sunny")weatherTrans="맑음";
   else if(weatherTrans=="rain")weatherTrans="비";
   else if(weatherTrans=="snow")weatherTrans="눈";
   
      // 마커가 표시될 위치입니다 
      var markerPosition  = new kakao.maps.LatLng(${data.latitude },${data.longitude }); 
       // 마커를 생성합니다
       var marker = new kakao.maps.Marker({
           //map: map, // 마커를 표시할 지도
           position: markerPosition // 마커의 위치
       });
       marker.setMap(map);
       var iwContent = '<div style="padding: 5px 0 0 10px;margin-right: 5px;width: 286px;height: 65px;">'+"${data.date }"+"-"+"${data.time }"+"/"+${data.assignmentNum }+"/"+"${data.namefull }"+"/"+${data.temperatures }+"ºC/"+weatherTrans+'</div>',
       iwPosition = new kakao.maps.LatLng(${data.latitude }, ${data.longitude }); //인포윈도우 표시 위치입니다
      // 인포윈도우를 생성합니다
       var infowindow = new kakao.maps.InfoWindow({
           position : iwPosition, 
           content : iwContent 
       });
         
       // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
       infowindow.open(map, marker); 
   
 
</script>
   <!--<script src="https://code.jquery.com/jquery-3.1.1,min.js"></script>
<srcipt scr="js/bootstrap.js"></srcipt>-->

</body>
</html>