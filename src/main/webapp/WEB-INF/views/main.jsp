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
   <!-- 그래프를 위한 스크립트 -->
   <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
   

   
<title>천안시 열지도 프로젝트</title>
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
                     <li class="active"><a href="/heatmap/">소개</a></li>
                     <li><a href="/heatmap/mapCheck">열지도 보기</a></li>
                     <!-- if자리 -->
                      <%
              if(id == null){ //미로그인시
           %>
           
                     
                        <li><a href="/heatmap/Login">열지도 만들기</a></li>
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
                           <li><a href="/heatmap/setTime">시간 설정</a></li>
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
   
   
   
   <header id="fh5co-header" class="fh5co-cover js-fullheight" role="banner"  style="background-image: url(resources/images/배경이미지.jpg); background-size:100% 100%; background-position: center;">
      <div class="overlay"></div>
      <div class="container"  >
         <div class="row">
            <div class="col-md-8 col-md-offset-2 text-center">
               <div class="display-t js-fullheight">
                  <div class="display-tc js-fullheight animate-box" data-animate-effect="fadeIn">
                     <h1>건강한 지역 사회 만들기 &amp; 열지도 프로젝트</h1>
                     <h2>천안 녹색 소비자연대</h2>
                     <p><a class="btn btn-primary btn-lg btn-demo" href="#fh5co-wireframe"></i>소개</a> <a class="btn btn-primary btn-lg btn-learn"  href="/heatmap/mapCheck">열지도 보기</a></p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </header>
   
   
   
   
   <div id="fh5co-slider">
      <div class="container">
         <div class="row">
            <div class="col-md-6 animate-box">
               <div class="heading">
                  <h2>천안시 열지도</h2>
                  <p>열지도 프로젝트에 참여해주신 분들의 사진입니다.</p>
               </div>
               <div class="container"> <canvas id="lineCanvas"></canvas> </div>

            </div>
            
            
            <!-- 삭제한 부분 -->
            
            
            
         </div>
      </div>
   </div>
   
   
   
   
   
   
   
      
   <div id="fh5co-wireframe" >
      <div class="container">
         <div class="row animate-box">
            <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
         <hr width = "90%" color = "red">
               <h2><img src="resources/img/소비자연대.jpg" style=" margin-right: 20px; margin-bottom: 1px; width:300px; height:100px;" ></h2>
            </div>
         </div>
         <div class="row">
            <div class="col-md-6 animate-box">
               <div class="user-frame">
                  <h5><span style = "font-weight:400;">단체 소개</span></h5>
                  <p>천안 녹색 소비자연대는 비정부, 비정당, 비영리 민간단체인 '녹색 소비자연대'의 천안 지부로 1997년에 설립되었습니다.
               
               <br>100% 시민의 기부금으로 운영되는 시민단체로서 천안 시민의 곁에서 깨끗하고 건강한 지역사회를 만들기 위한 다양한 활동을 하고 있습니다. </p>
                  
               </div>
            </div>
            
         
            
            <div class="col-md-6 animate-box">
            
               <div class="user-frame">
                  <h5>천안시 열지도 프로젝트</h5>
                  <p>천안시 열지도 사업은 2017년에 처음 시작된 조사연구 활동입니다.<br> 본 사업에서 천안시 곳곳의 실외기온을 시민이 직접 측정해 만든 '열지도'는 천안시 기후변화의 기록물로 활용됩니다. </p>
                  
               </div>
               
            </div>
         </div>
      </div>
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










<div class="gototop js-top">
      <a href="#" class="js-gotop"><i class="icon-arrow-up22"></i></a>
   </div>
   
   
   <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>


   <script> var ctx = document.getElementById('myChart').getContext('2d'); 
   var chart = new Chart(ctx, {
      // 챠트 종류를 선택
      type: 'line',
      // 챠트를 그릴 데이타
      
      data: { 
         labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'], 
         datasets: [{ 
            label: 'My First dataset', 
            backgroundColor: 'transparent',
            borderColor: 'red', 
            data: [0, 10, 5, 2, 20, 30, 45]
         }]
   },
   // 옵션 
   options: {}
   }); </script>
-->

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
   
   <script>
   var ctx = document.getElementById("lineCanvas").getContext("2d");
   //function lineChart(){
      var chart = new Chart(ctx, {
              //labels: ["월","화","수","목","금","토","일"],
            type: 'line',
              data: { 
               labels: ["${dateList[6]}","${dateList[5]}","${dateList[4]}","${dateList[3]}","${dateList[2]}","${dateList[1]}","${dateList[0]}"],
               datasets: [{ 
                  label: "최저온도",
                  lineTension: 0,
                  backgroundColor: 'rgba(255, 255, 255, 0)',
                  borderColor: 'rgba(000, 153, 000, 1)',
                      pointColor: "rgba(220,220,220,1)",
                      pointStrokeColor: "#fff",
                      pointHighlightFill: "#fff",
                      pointHighlightStroke: "rgba(220,220,220,1)",
                      data: [${temperaturesMin[6]}, ${temperaturesMin[5]}, ${temperaturesMin[4]}, ${temperaturesMin[3]}, ${temperaturesMin[2]}, ${temperaturesMin[1]}, ${temperaturesMin[0]}]
               },
               { 
                  label: "최고온도",
                  lineTension: 0,
                  backgroundColor: "rgba(255, 255, 255, 0)",
                  borderColor: "rgba(255,204,000,1)",
                      pointColor: "rgba(151,187,205,1)",
                      pointStrokeColor: "#fff",
                      pointHighlightFill: "#fff",
                      pointHighlightStroke: "rgba(151,187,205,1)",
                      data: [${temperaturesMax[6]}, ${temperaturesMax[5]}, ${temperaturesMax[4]}, ${temperaturesMax[3]}, ${temperaturesMax[2]}, ${temperaturesMax[1]}, ${temperaturesMax[0]}]
               },
               { 
                   label: "평균온도",
                   lineTension: 0,
                   backgroundColor: "rgba(255, 255, 255, 0)",
                   borderColor: "rgba(255,204,000,1)",
                       pointColor: "rgba(151,187,205,1)",
                       pointStrokeColor: "#fff",
                       pointHighlightFill: "#fff",
                       pointHighlightStroke: "rgba(151,187,205,1)",
                       data: [${temperaturesAvg[6]}, ${temperaturesAvg[5]}, ${temperaturesAvg[4]}, ${temperaturesAvg[3]}, ${temperaturesAvg[2]}, ${temperaturesAvg[1]}, ${temperaturesAvg[0]}]
                }
               
               ]
               },
               // 옵션 
               options: {}
               }); 
          
          
          //var options = { };
          //var lineChart = new Chart(ctx).Line(data, options);

   //}
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