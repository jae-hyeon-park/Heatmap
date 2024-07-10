<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <meta name="description" content="Free HTML5 Website Template by freehtml5.co" />
   <meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free 

website template, html5, css3, mobile first, responsive" />
   <meta name="author" content="freehtml5.co" />
<style type="text/css">
form {
	display: inline;
}
</style>
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
   
<title>Insert title here</title>
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
                  <div id="fh5co-logo"><a href="/heatmap/"> 천안시 

열지도<span>.</span></a><br><h4>&nbsp;&nbsp;CHEONANSI &nbsp; HEAT MAP</h4></div>
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
                           
                           <li><a href="/heatmap/result">전체 측정 기록</a></li>      <!-- 관리자가 전체 측정보

는곳 -->
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
   <div class="container">
      <div class="col-lg-15"></div>
      <div class="col-lg-15">
         <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action=setTime>
            <br><br>
               <h3 style="text-align: left;">시간 제한 설정</h3>
               <input type='date' id="dateSet" name="dateSet" required>
             &nbsp;&nbsp;&nbsp;
				<input type="time" id="timeString" name="timeString" required>
            <input type="submit" class="btn btn-primary" value="설정">
          
             <!--
           <input type="button" class="btn btn-primary" id="button1" onclick="button1_click();" value="초기화" style="float: right;" />
           -->
           
            </form>
            
            
              <form method="post" action="deleteAll">
         
         <input type="submit" value="초기화" class="btn btn-primary" style="float: right;">
      </form>
      
            
            
            <br><br>
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						
						<th style="background-color: #eeeeee; text-align: center;">설정날짜</th>
						<th style="background-color: #eeeeee; text-align: center;">시작시간</th>
						<th style="background-color: #eeeeee; text-align: center;">설정삭제</th>
					</tr>
				</thead>
				<tbody>
				
				<c:forEach items="${setdata}" var="list">      
         			<tr> 
         				<td>${list.dateSet }</td>
         				<td>${list.timeSet }</td>   
         				<td>
         					<form method="post" action=deleteTime>
         						<input type='date' id="dateSet" name="dateSet" value="${list.dateSet }" hidden>
         						<input type="time" id="timeSet" name="timeSet" value="${list.timeSet }" hidden>
         						<input type="submit" value="x">
         					</form>
         				</td>
         			</tr>             
   				</c:forEach>
				
				</tbody>
				
			</table>
            
         </div>
         <br><br>
      </div>
      <div class="col-lg-15"></div>
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
   <script>
	function button1_click() {
		console.log("버튼1을 누르셨습니다.");
		window.alert("출력");
		}
			</script>
  
</body>
</html>