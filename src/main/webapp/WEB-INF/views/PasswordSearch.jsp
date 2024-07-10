<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
               <div class="col-xs-4">
                  <div id="fh5co-logo"><a href="/heatmap/"> 천안시  열지도<span>.</span></a></div>
               </div>
               <div class="col-xs-8 text-right menu-1">
                  <ul>
                     <li ><a href="/heatmap/">소개</a></li>
                     <li><a href="/heatmap/mapCheck">열지도 보기</a></li>
                     <!-- if자리 -->
                      <%
              if(id == null){ //미로그인시
           %>
           
                     <li class="has-dropdown">
                        <a class="active">열지도 만들기</a>
                        <ul class="dropdown">
                           <li><a href="/heatmap/join">회원가입</a></li>
                           <li><a href="/heatmap/Login">로그인</a></li>
                           
                        </ul>
                        </li>
                           <li><a href="/heatmap/join">회원가입</a></li>
                           <li><a href="/heatmap/Login">로그인</a></li>
                           
                        
                        
                        
                     
                                       
             <%
              } else{ //로그인 및 회원가입으로 인하여 로그인 된 경우
                 if(mtype.equals("admin")){ //관리자가 로그인한 경우
              %>
              
              <li class="has-dropdown">
                        <a href="blog.html" >열지도 만들기</a>
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
                        <a href="blog.html" >열지도 만들기</a>
                        <ul class="dropdown">
                           <li><a href="/heatmap/myLocation">측정자료 올리기</a></li> <!-- 현재위치 부터 받기에 myLocation -->
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
      <div class="col-lg-15"></div>
      <div class="col-lg-15">
         <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action="PasswordSearchCon">
            <br><br>
               <h3 style="text-align: center;">비밀번호 찾기</h3>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="아이디" name="id" maxlength="20" required>
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" placeholder="이메일" name="email" maxlength="20" required>
               </div>
               <input type="submit" class="btn btn-primary form-control" value="비밀번호 찾기">
            </form>
            <br>
            <a href="/heatmap/Login" class="btn btn-primary form-control" role="button">취소</a>
         </div>
      </div>
      <div class="col-lg-15"></div>
      <br><br><br><br>
      
      
   
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

</body>
</html>