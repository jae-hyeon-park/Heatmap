<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="kr.or.connect.heatmap.dto.HeatMapFormData" %>
    <%@ page import="kr.or.connect.heatmap.dao.HeatMapFormDao" %>
    <%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import ="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@ page import ="org.springframework.stereotype.Controller"%>
<%@ page import= "org.springframework.web.bind.annotation.GetMapping" %>
<%@ page import ="org.springframework.web.bind.annotation.ModelAttribute"%>
<%@ page  import= "org.springframework.web.bind.annotation.PostMapping"%>
<%@ page  import=" org.springframework.web.bind.annotation.RequestMapping"%>
<%@ page import= "org.springframework.web.servlet.ModelAndView"%>

<%@ page import= "kr.or.connect.heatmap.config.ApplicationConfig"%>
<%@ page import= "kr.or.connect.heatmap.dao.MemberDao"%>
<%@ page import= "kr.or.connect.heatmap.dao.HeatMapFormDao"%>
<%@ page import= " kr.or.connect.heatmap.dto.Member"%>
<%@ page import= " kr.or.connect.heatmap.dto.HeatMapFormData"%>
<%@ page import= " java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
  
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
		int idNum=-1;
		String id = null;
		String mtype = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
			mtype = (String)session.getAttribute("mtype");
		}
		
		if (session.getAttribute("idNum") != null) {
			idNum = Integer.parseInt(String.valueOf(session.getAttribute("idNum"))); 
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
	<div class="table-responsive">
		<div>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">측정날짜</th>
						<th style="background-color: #eeeeee; text-align: center;">측정시간</th>
						<th style="background-color: #eeeeee; text-align: center;">측정지</th>
						<th style="background-color: #eeeeee; text-align: center;">배정번호</th>
						<th style="background-color: #eeeeee; text-align: center;">온도</th>
						<th style="background-color: #eeeeee; text-align: center;">기상상태</th>
						<th style="background-color: #eeeeee; text-align: center;">사진</th>
						
					</tr>
				</thead>
				<tbody>
				<%
				/*ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
				HeatMapFormDao formdao3 = ac.getBean(HeatMapFormDao.class);
				List<HeatMapFormData> list = formdao3.selectIdAll(id);
				int i=0;
				for(HeatMapFormData data : list) {
					i++;*/
				ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
				HeatMapFormDao manager = ac.getBean(HeatMapFormDao.class);	
					
				int pageSize = 10; // 한 페이지에 출력할 레코드 수

				// 페이지 링크를 클릭한 번호 / 현재 페이지
				String pageNum = request.getParameter("pageNum");
				if (pageNum == null){ // 클릭한게 없으면 1번 페이지
					pageNum = "1";
				}
				// 연산을 하기 위한 pageNum 형변환 / 현재 페이지
				int currentPage = Integer.parseInt(pageNum);
				System.out.println("currentPage"+currentPage);
				// 해당 페이지에서 시작할 레코드 / 마지막 레코드
				int startRow = (currentPage - 1) * pageSize + 1;
				int endRow = currentPage * pageSize;
				System.out.println("startRow"+startRow);
				System.out.println("endRow"+endRow);
				
				int count = 0;
				count = manager.getIdCount(idNum); // 데이터베이스에 저장된 총 갯수
				System.out.println("count"+count);
				
				List<HeatMapFormData> list = null;
				if (count > 0) {
					// getList()메서드 호출 / 해당 레코드 반환
					list = manager.selectMyId(startRow-1, endRow,id,idNum);
				}
				if (count > 0) { // 데이터베이스에 데이터가 있으면
					int number = count - (currentPage - 1) * pageSize; // 글 번호 순번 
					int recordNum = number;
					for (int i = 0; i < list.size(); i++) {
						HeatMapFormData board = list.get(i); // 반환된 list에 담긴 참조값 할당
				%>
				<tr> 
					<td><%= recordNum %></td>
					<td><%= board.getDate() %></td>
					<td><%= board.getTime() %></td>
					<td><%= board.getArea1() %></td>
					<td><%= board.getAssignmentNum() %></td>
					<td><%= board.getTemperatures() %></td>
					<c:set var="weather" value="<%= board.getWeather() %>" />
                  <c:choose>
                        <c:when test="${weather eq 'blur' }"><td>흐림</td></c:when>
                        <c:when test="${weather eq 'sunny' }"><td>맑음</td></c:when>
                        <c:when test="${weather eq 'rain' }"><td>비</td></c:when>
                        <c:when test="${weather eq 'snow' }"><td>눈</td></c:when>
                        <c:otherwise>5. 기상상태: [${data.weather }]</c:otherwise>
                  </c:choose>
					<td><img src="<%=board.getUrl() %>"  width="100" height="100" alt="NO IMAGE"></td>
				</tr>
				
				<%
						recordNum = recordNum-1;
					}
				}else{
				
				%>
				<tr>
					<td colspan="6" align="center">게시글이 없습니다.</td>
				</tr>
				<%
					}
				%>
				
				</tbody>
				
			</table>
			</div>
			<% 
				if(count > 0){
					// 총 페이지의 수
					int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
					// 한 페이지에 보여줄 페이지 블럭(링크) 수
					int pageBlock = 10;
					// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
					int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
					int endPage = startPage + pageBlock - 1;
					
					// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
					if(endPage > pageCount){
						endPage = pageCount;
					}
				
					if(startPage > pageBlock){ // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
			%>
						<a href="myList?pageNum=<%=startPage - 10%>">[이전]</a>	
			<%			
					}
				
					for(int i=startPage; i <= endPage; i++){ // 페이지 블록 번호
						if(i == currentPage){ // 현재 페이지에는 링크를 설정하지 않음
			%>
							[<%=i %>]
			<%									
						}else{ // 현재 페이지가 아닌 경우 링크 설정
			%>
							<a href="myList?pageNum=<%=i%>">[<%=i %>]</a>
			<%	
						}
					} // for end
				
					if(endPage < pageCount){ // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
			%>
						<a href="myList?pageNum=<%=startPage + 10 %>">[다음]</a>
			<%			
					}
				}
			%>

			
		</div>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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