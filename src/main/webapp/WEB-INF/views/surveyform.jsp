<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
   if(id == null ){  //응답폼 등록하려할때 로그인이나 회원가입으로 넘어온 id가 없을경우
		PrintWriter script = response.getWriter();
		script.println("<script> location.href = '/heatmap/Login';</script>");
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
         <form method="post" action=surveyformCheck
            enctype="multipart/form-data">
            <div class="card-header">
               <h3 class="text-center font-weight-light my-4">온도 체크 설문지</h3>
            </div>
            <div class="card-body">

               <div class="form-group"></div>
               <label for="assignmentNum" class="form-label">1. 배정번호</label> 
               <input type="number" id="assignmentNum" class="form-control"
                  name="assignmentNum" required>
                  <br>
               <div class="mb-3">
                  <label for="namefull" class="form-label">2. 측정자 성명</label> 
                  <input type="text" id="namefull" class="form-control" name="namefull"
                     placeholder="예) 홍길동 " required>
               </div>
			<br>
               <div class="mb-3">
                  <label for="area1" class="form-label">3. 측정지</label> 
                  <input type="text" id="area1" class="form-control" name="area1"
                     value="${data.area1 }" readonly>
               </div>
<br>
               <div class="mb-3">
                  <label for="Temperatures" class="form-label">4. 측정 기온</label> 
                  <input type="number" step="0.1" id="temperatures" class="form-control"
                     name="temperatures" placeholder="예) 30 " required>
               </div>
<br>
               <div class="form-group">
                  <label class="Extra Extra large mb-1">5. 측정 당시 기상상태 </label> 
                  <select name="weather" id="weather">
                     <option value='sunny'>맑음</option>
                     <option value='blur'>흐림</option>
                     <option value='rain'>비</option>
                     <option value='snow'>눈</option>
                  </select>
               </div>
               <br>
               <div class="mb-3">
                  <label for="input_img" class="form-label">6. 측정 사진 첨부</label> <br>
                  <img src="resources/img/9-2.jpeg" class="img-fluid"
                     alt="페이지에 이미지 삽입 불가"> <br>
                  <br> <input class="form-control" type="file" accept="image/*" name="file1"
                     id="input_img" onchange="fileCheck(this);" required>
               </div>
               <div class="img_wrap">
                  <img id="img" >
               </div>
               <br> <input class="form-check-input" type="text" id="latitude"
                  name="latitude" value="${data.latitude }" hidden> 
                  <input class="form-check-input" type="text" id="longitude"
                  name="longitude" value="${data.longitude }" hidden>
               <div class="d-grid gap-2 d-md-flex justify-content-md-end">
               <input type="submit" class="btn btn-primary" value="다음"  style="float: right;">
                  <a href="javascript:history.back()" class="btn btn-primary" 
                     role="button" style="float: left;">뒤로</a> 
               </div>
            </div>
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
   <script type="text/javascript"> 

	function fileCheck(el) { 
    	if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
        	alert('이미지 파일만 업로드 가능합니다.'); 
        	el.value = ''; 
        	el.focus(); 
    	}
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
   <script src="resources/js/image.js"></script>
</body>
</html>