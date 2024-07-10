<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="kr.or.connect.heatmap.dto.HeatMapFormData" %>
    <%@ page import="kr.or.connect.heatmap.dao.HeatMapFormDao" %>
    <%@ page import="org.springframework.context.ApplicationContext"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import ="org.springframework.context.annotation.AnnotationConfigApplicationContext"%>
<%@ page import ="org.springframework.stereotype.Controller"%>
<%@ page import= "org.springframework.web.bind.annotation.GetMapping" %>
<%@ page import ="org.springframework.web.bind.annotation.ModelAttribute"%>
<%@ page  import= "org.springframework.web.bind.annotation.PostMapping"%>
<%@ page  import=" org.springframework.web.bind.annotation.RequestMapping"%>
<%@ page import= "org.springframework.web.servlet.ModelAndView"%>

<%@ page import= "kr.or.connect.heatmap.config.ApplicationConfig"%>
<%@ page import= "kr.or.connect.heatmap.dao.MapCheckDao"%>
<%@ page import= "kr.or.connect.heatmap.dao.HeatMapFormDao"%>

<%@ page import= " kr.or.connect.heatmap.dto.MapCheckData"%>
<%@ page import= " kr.or.connect.heatmap.dto.HeatMapFormData"%>
<%@ page import= " kr.or.connect.heatmap.dto.pastSurveyFormData"%>

<%@ page import= " java.util.List"%>
<%@ page import= " java.util.ArrayList"%>
<%@ page import= " java.text.DecimalFormat"%>
<%@ page import= "java.sql.Date"%>
<%@ page import= "java.sql.Time"%>
<%@ page import= "java.text.SimpleDateFormat"%>
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
        	width:auto;
            float: right;
        }
</style>
</head>
<body>
  <%
	//메인페이지 jsp -> 세션을 통해 id를 받아서 누가로그인 한지 확인
  		String id = null;
		String mtype = null;
		if(session.getAttribute("id") != null){
		id = (String)session.getAttribute("id");
		mtype = (String)session.getAttribute("mtype");
	}
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		//초기값 할당
		if(year==null){
			year="1111";
			month="99";
			day="99";
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
							<li class="active"><a href="/heatmap/mapCheck">열지도 보기</a></li>
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
   
   
   <!-- 색 레이블 이미지 -->

   <!--  여기까지 -->  
<div class="container">
<form method="post" action="MapC" enctype="multipart/form-data">
<div class="jumbotron jumbotron-fluid">

<div style="text-align:center">
   Quick Search :
   <select name="datelist" id="datelist" onchange="typechange()" <span style="font-size:0.7em;"></span>>
             <option value="0-0-0">기록일 선택</option> 
   <c:forEach items="${dateList}" var="list">      
         <option value="${ list}">${ list}</option>              
   </c:forEach>
   </select>
   &nbsp;&nbsp;&nbsp;
   <c:set var="year" value="${year}" />
        <select name="year" id="year" <span style="font-size:0.7em;"></span>>
              <option id="yearNum" value="0" >년</option>
              <option value="2017" <c:if test="${year eq '2017'}">selected</c:if>>2017년</option>
              <option value="2018" <c:if test="${year eq '2018'}">selected</c:if>>2018년</option>
              <option value="2019" <c:if test="${year eq '2019'}">selected</c:if>>2019년</option>
              <option value="2020" <c:if test="${year eq '2020'}">selected</c:if>>2020년</option>
                <option value="2021" <c:if test="${year eq '2021'}">selected</c:if>>2021년</option>
                <option value="2022" <c:if test="${year eq '2022'}">selected</c:if>>2022년</option>
                <option value="2023" <c:if test="${year eq '2023'}">selected</c:if>>2023년</option>
                <option value="2024" <c:if test="${year eq '2024'}">selected</c:if>>2024년</option>
                <option value="2025" <c:if test="${year eq '2025'}">selected</c:if>>2025년</option>
                <option value="2026" <c:if test="${year eq '2026'}">selected</c:if>>2026년</option>
                <option value="2027" <c:if test="${year eq '2027'}">selected</c:if>>2027년</option>
                <option value="2028" <c:if test="${year eq '2028'}">selected</c:if>>2028년</option>
                <option value="2029" <c:if test="${year eq '2029'}">selected</c:if>>2029년</option>
                <option value="2030" <c:if test="${year eq '2030'}">selected</c:if>>2030년</option>
        </select>
        
        <c:set var="month" value="${month}" />
        <select name="month" id="month" <span style="font-size:0.7em;"></span>>
              <option id="monthNum" value="0">월</option>
                <option value="01" <c:if test="${month eq '01'}">selected</c:if>>1월</option>
                <option value="02" <c:if test="${month eq '02'}">selected</c:if>>2월</option>
                <option value="03" <c:if test="${month eq '03'}">selected</c:if>>3월</option>
                <option value="04" <c:if test="${month eq '04'}">selected</c:if>>4월</option>
                <option value="05" <c:if test="${month eq '05'}">selected</c:if>>5월</option>
                <option value="06" <c:if test="${month eq '06'}">selected</c:if>>6월</option>
                <option value="07" <c:if test="${month eq '07'}">selected</c:if>>7월</option>
                <option value="08" <c:if test="${month eq '08'}">selected</c:if>>8월</option>
                <option value="09" <c:if test="${month eq '09'}">selected</c:if>>9월</option>
                <option value="10" <c:if test="${month eq '10'}">selected</c:if>>10월</option>
                <option value="11" <c:if test="${month eq '11'}">selected</c:if>>11월</option>
                <option value="12" <c:if test="${month eq '12'}">selected</c:if>>12월</option>
        </select>
        
        <c:set var="day" value="${day}" />
        <select name="day" id="day" <span style="font-size:0.7em;"></span>>
              <option id="dayNum" value="0">일</option>
                <option value="01" <c:if test="${day eq '01'}">selected</c:if>>1일</option>
                <option value="02" <c:if test="${day eq '02'}">selected</c:if>>2일</option>
                <option value="03" <c:if test="${day eq '03'}">selected</c:if>>3일</option>
                <option value="04" <c:if test="${day eq '04'}">selected</c:if>>4일</option>
                <option value="05" <c:if test="${day eq '05'}">selected</c:if>>5일</option>
                <option value="06" <c:if test="${day eq '06'}">selected</c:if>>6일</option>
                <option value="07" <c:if test="${day eq '07'}">selected</c:if>>7일</option>
                <option value="08" <c:if test="${day eq '08'}">selected</c:if>>8일</option>
                <option value="09" <c:if test="${day eq '09'}">selected</c:if>>9일</option>
                <option value="10" <c:if test="${day eq '10'}">selected</c:if>>10일</option>
                <option value="11" <c:if test="${day eq '11'}">selected</c:if>>11일</option>
                <option value="12" <c:if test="${day eq '12'}">selected</c:if>>12일</option>
                <option value="13" <c:if test="${day eq '13'}">selected</c:if>>13일</option>
                <option value="14" <c:if test="${day eq '14'}">selected</c:if>>14일</option>
                <option value="15" <c:if test="${day eq '15'}">selected</c:if>>15일</option>
                <option value="16" <c:if test="${day eq '16'}">selected</c:if>>16일</option>
                <option value="17" <c:if test="${day eq '17'}">selected</c:if>>17일</option>
                <option value="18" <c:if test="${day eq '18'}">selected</c:if>>18일</option>
                <option value="19" <c:if test="${day eq '19'}">selected</c:if>>19일</option>
                <option value="20" <c:if test="${day eq '20'}">selected</c:if>>20일</option>
                <option value="21" <c:if test="${day eq '21'}">selected</c:if>>21일</option>
                <option value="22" <c:if test="${day eq '22'}">selected</c:if>>22일</option>
                <option value="23" <c:if test="${day eq '23'}">selected</c:if>>23일</option>
                <option value="24" <c:if test="${day eq '24'}">selected</c:if>>24일</option>
                <option value="25" <c:if test="${day eq '25'}">selected</c:if>>25일</option>
                <option value="26" <c:if test="${day eq '26'}">selected</c:if>>26일</option>
                <option value="27" <c:if test="${day eq '27'}">selected</c:if>>27일</option>
                <option value="28" <c:if test="${day eq '28'}">selected</c:if>>28일</option>
                <option value="29" <c:if test="${day eq '29'}">selected</c:if>>29일</option>
                <option value="30" <c:if test="${day eq '30'}">selected</c:if>>30일</option>
                <option value="31" <c:if test="${day eq '31'}">selected</c:if>>31일</option>
        </select>

      <input class="btn btn-primary" type="submit" value="검색">
      </div>
       
 
  
				<%
				/*
				ArrayList<String> arrAreaList = new ArrayList<>();
				ArrayList<String> arrWeatherList = new ArrayList<>();
				ArrayList<Integer> arrAssignmentNumList = new ArrayList<>();
				ArrayList<Float> arrTemperaturesList = new ArrayList<>();
				ArrayList<Double> arrLatList = new ArrayList<>();
				ArrayList<Double> arrLogList = new ArrayList<>();
				*/
				Time[] arrTime = new Time[300];
				String[] arrArea = new String[300];
				String[] arrWeather = new String[300];
				int[] arrAssigmentNum = new int[300];
				float[] arrTemperatures = new float[300];
				double[] arrLat=new double[300];
				double[] arrLog=new double[300];
				//2021년 05월 이후 데이터베이스 surveyform
				if(Integer.parseInt(year)>=2021&&Integer.parseInt(month)>5||Integer.parseInt(year)>2021){
				ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
				MapCheckDao formdao = ac.getBean(MapCheckDao.class);
				List<MapCheckData> list = formdao.selectAll(year,month,day);
				
				String dateY,dateM,dateD; //db에 년,월,일 을 받는 문자열
				
				String area = new String();
				int assigmentNum = 0;
				float temperatures = 0;
				String weather = new String();
				double lat=0,log=0;
				
				int i=0;
				double highTem = 0.0, avgTem = 0.0, lowTem=100;
				
				for(MapCheckData data : list) {
					

				%>
				
				<tr> 
					<%if(year!=null&&month!=null){
					SimpleDateFormat sDateY,sDateM,sDateD;
					sDateY = new SimpleDateFormat("yyyy");
					sDateM = new SimpleDateFormat("MM");
					sDateD = new SimpleDateFormat("dd");
					dateY = sDateY.format(data.getDate());
					dateM = sDateM.format(data.getDate());
					dateD = sDateM.format(data.getDate());

					if(year.equals(dateY)&&month.equals(dateM)&&month.equals(dateD)){
					
					
					

					data.getDate();
					arrTime[i] = data.getTime();
					arrArea[i] = data.getArea1();
					arrAssigmentNum[i] = data.getAssignmentNum();
					arrTemperatures[i] = data.getTemperatures();
					arrWeather[i] = data.getWeather();
					arrLat[i] = data.getLatitude();
					arrLog[i] = data.getLongitude();
					
					
					if(i==0){
						avgTem=data.getTemperatures();
						highTem=data.getTemperatures();
						lowTem=data.getTemperatures();
						i++;
					}
					else{
						avgTem+=data.getTemperatures();
					if(highTem<data.getTemperatures())highTem=data.getTemperatures();
					if(lowTem>data.getTemperatures())lowTem=data.getTemperatures();
					i++;
					}
					}
					} %>
				</tr>

				
				<%	
				}
				//평균 구해서 소수점 첫째자리 까지만 남기는 과정
				DecimalFormat decimal = new DecimalFormat();
				decimal.applyLocalizedPattern("0.0");
				avgTem = avgTem/i;
				i=0;
				%>
					   <div style="text-align:center">
						<%if(lowTem==100){ %>
					   <p class="lead"><span style="font-size:0.7em;">최저온도</span> &nbsp;&nbsp;&nbsp; <span style="font-size:0.7em;">최고온도</span> &nbsp;&nbsp;&nbsp;<span style="font-size:0.7em;"><b>평균온도</b></span> </p>
					   <% }else{%>
					   <p class="lead"><span style="font-size:0.7em;">최저온도</span> <b><%= decimal.format(lowTem) %><span style="font-size:0.8em;">ºC</span></b>&nbsp;&nbsp;&nbsp; <span style="font-size:0.7em;">최고온도</span> <b><%= decimal.format(highTem) %><span style="font-size:0.8em;">ºC</span></b> &nbsp;&nbsp;&nbsp;<span style="font-size:0.7em;"><b>평균온도</b></span> <b><%= decimal.format(avgTem) %><span style="font-size:0.8em;">ºC</span></b></p>
					   <%} %>
					   
					   
					   
					   
					   </div>				
				<% 
				}else{//2021년 05월 이전 데이터베이스 surveyform
					ApplicationContext ac1 = new AnnotationConfigApplicationContext(ApplicationConfig.class);
					MapCheckDao formdao1 = ac1.getBean(MapCheckDao.class);
					List<MapCheckData> list = formdao1.selectAllPast(year, month, day);
					
					String dateY,dateM,dateD; //db에 년,월,일 을 받는 문자열
					
					String area = new String();

					int i=0;
					double highTem = 0.0, avgTem = 0.0, lowTem=100;
					
					for(MapCheckData data : list) {	
						
						
					
					%>
					
					<tr> 
						<%if(year!=null&&month!=null){
						SimpleDateFormat sDateY,sDateM,sDateD;
						sDateY = new SimpleDateFormat("yyyy");
						sDateM = new SimpleDateFormat("MM");
						sDateD = new SimpleDateFormat("dd");
						dateY = sDateY.format(data.getDate());
						dateM = sDateM.format(data.getDate());
						dateD = sDateM.format(data.getDate());

						area = data.getArea1();
						if(year.equals(dateY)&&month.equals(dateM)&&month.equals(dateD)){
	
						
						arrTime[i] = data.getTime();
						arrArea[i] = data.getArea1();
						arrTemperatures[i] = data.getTemperatures();
						arrLat[i] = data.getLatitude();
						arrLog[i] = data.getLongitude();

						
						if(i==0){
							avgTem=data.getTemperatures();
							highTem=data.getTemperatures();
							lowTem=data.getTemperatures();
							System.out.println("lowTem : "+lowTem);
							i++;
						}
						else{
							avgTem+=data.getTemperatures();
						if(highTem<data.getTemperatures())highTem=data.getTemperatures();
						if(lowTem>data.getTemperatures())lowTem=data.getTemperatures();
						i++;
						}
						}
						} %>
					</tr>

					
					<%
						
					}
					//평균 구해서 소수점 첫째자리 까지만 남기는 과정
					DecimalFormat decimal = new DecimalFormat();
					decimal.applyLocalizedPattern("0.0");
					avgTem = avgTem/i;
					i=0;
					
					%>
										   <div style="text-align:center">
						<%if(lowTem==100){ %>
					   <p class="lead"><span style="font-size:0.7em;">최저온도</span> &nbsp;&nbsp;&nbsp; <span style="font-size:0.7em;">최고온도</span> &nbsp;&nbsp;&nbsp;<span style="font-size:0.7em;"><b>평균온도</b></span> </p>
					   <% }else{%>
					   <p class="lead"><span style="font-size:0.7em;">최저온도</span> <b><%= decimal.format(lowTem) %><span style="font-size:0.8em;">ºC</span></b>&nbsp;&nbsp;&nbsp; <span style="font-size:0.7em;">최고온도</span> <b><%= decimal.format(highTem) %><span style="font-size:0.8em;">ºC</span></b> &nbsp;&nbsp;&nbsp;<span style="font-size:0.7em;"><b>평균온도</b></span> <b><%= decimal.format(avgTem) %><span style="font-size:0.8em;">ºC</span></b></p>
					   <%} %>
					   
					   </div>				
					<%
				}
				%>		


   		<div class="sidemenu">
		<img src="resources/img/색 레이블.PNG"  >
        </div>   
   <div id="map" style="width:auto; margin-top:30px; margin-right:120px; height:473px;"></div>
			
				
			</div>
</div> 
   <br><br><br>
</form>



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
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e27ccf00f1a03975beba4aef431af12b"></script>
   <script>
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
   mapOption = { 
       center: new kakao.maps.LatLng(36.818181037231, 127.13555893329792), // 지도의 중심좌표
       level: 5 // 지도의 확대 레벨
   };
   
   var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
   	var arrTime = [];
	var arrArea = [];
	var arrWeather = [];
	var arrAssigmentNum = [];
	var arrTemperatures = [];
	var arrLat= [];
	var arrLog= [];
	
	<%if(Integer.parseInt(year)>=2021&&Integer.parseInt(month)>5||Integer.parseInt(year)>2021){%>
	<%for(int a=0;a<300;a++){%>
	arrTime[<%=a%>]='<%=arrTime[a]%>';
	arrArea[<%=a%>]='<%=arrArea[a]%>';
	arrWeather[<%=a%>]='<%=arrWeather[a]%>';
	arrAssigmentNum[<%=a%>]='<%=arrAssigmentNum[a]%>';
	arrTemperatures[<%=a%>]='<%=arrTemperatures[a]%>';
	arrLat[<%=a%>]='<%=arrLat[a]%>';
	arrLog[<%=a%>]='<%=arrLog[a]%>';
	<%}%>

   for(let i=0;i<300;i++){
   	
	   //날씨 한글변환할때 쓰는 변수
	   <%int Wcount = 0;%>
	   
	   var position =  new kakao.maps.LatLng(arrLat[i],arrLog[i]);
       var temInt = arrTemperatures[i];
	   //마커 이미지 경로
	   /*
			   if(temInt<16)var imageSrc = "resources/img/진한파랑.png";
			   else if(temInt>=16&&temInt<17)var imageSrc = "resources/img/파랑.png";
			   else if(temInt>=17&&temInt<19)var imageSrc = "resources/img/하늘.png";
			   else if(temInt>=19&&temInt<21)var imageSrc = "resources/img/하늘.png";
			   else if(temInt>=21&&temInt<23)var imageSrc = "resources/img/연연빨강.png";
			   else if(temInt>=23&&temInt<25)var imageSrc = "resources/img/연연빨강.png";
			   else if(temInt>=25&&temInt<27)var imageSrc = "resources/img/연한빨강.png";
			   else if(temInt>=27&&temInt<29)var imageSrc = "resources/img/연한빨강.png";
			   else if(temInt>=29&&temInt<31)var imageSrc = "resources/img/연한빨강.png";
			   else if(temInt>=31&&temInt<33)var imageSrc = "resources/img/빨강.png";
			   else if(temInt>=33&&temInt<35)var imageSrc = "resources/img/빨강.png";
			   else if(temInt>=35&&temInt<40)var imageSrc = "resources/img/진한빨강.png";
			   else if(temInt>=40)var imageSrc = "resources/img/진한빨강.png";
	   */
	   
		   if(temInt<16)var imageSrc = "resources/img/15도.png";
		   else if(temInt>=16&&temInt<17)var imageSrc = "resources/img/16도.png";
		   else if(temInt>=17&&temInt<19)var imageSrc = "resources/img/17~18도.png";
		   else if(temInt>=19&&temInt<21)var imageSrc = "resources/img/19~20도.png";
		   else if(temInt>=21&&temInt<23)var imageSrc = "resources/img/21~22도.png";
		   else if(temInt>=23&&temInt<25)var imageSrc = "resources/img/23~24도.png";
		   else if(temInt>=25&&temInt<27)var imageSrc = "resources/img/25~26도.png";
		   else if(temInt>=27&&temInt<29)var imageSrc = "resources/img/27~28도.png";
		   else if(temInt>=29&&temInt<31)var imageSrc = "resources/img/29~30도.png";
		   else if(temInt>=31&&temInt<33)var imageSrc = "resources/img/31~32도.png";
		   else if(temInt>=33&&temInt<35)var imageSrc = "resources/img/33~34도.png";
		   else if(temInt>=35&&temInt<40)var imageSrc = "resources/img/35~39도.png";
		   else if(temInt>=40)var imageSrc = "resources/img/40도~.png";
	   
	   // 마커 이미지의 이미지 크기 입니다
	   var imageSize = new kakao.maps.Size(20, 20); 
	   // 마커 이미지를 생성합니다    
	   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	 	// 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        position: position,
	        image : markerImage, //마커 이미지
	        clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
	    });
	 	// 마커를 지도에 표시합니다.
	    marker.setMap(map);

	    // 날씨 데이터를 한글화 합니다
	    var weatherTrans ='<%=arrWeather[Wcount]%>';
	    if(weatherTrans=="blur")weatherTrans="흐림";
	    else if(weatherTrans=="sunny")weatherTrans="맑음";
	    else if(weatherTrans=="rain")weatherTrans="비";
	    else if(weatherTrans=="snow")weatherTrans="눈";
	    
	    // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
	    var iwContent = '<div style="padding: 5px 0 0 10px;margin-right: 5px;width: 286px;height: 65px;">'+arrTime[i]+'/'+arrArea[i]+'/'+arrAssigmentNum[i]+'/'+arrTemperatures[i]+'ºC/'+weatherTrans+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    //var iwContent = '<div style="padding:5px;">Hello World!</div>',    
	    	iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
	    
	    function makeClickListener(map, marker, infowindow) {
	    return function() {
	    infowindow.open(map, marker);
	    };
	    }
	    <%Wcount++;%>
   }
   <%}else{%>
	<%for(int a=0;a<300;a++){%>
	arrTime[<%=a%>]='<%=arrTime[a]%>';
	arrArea[<%=a%>]='<%=arrArea[a]%>';
	arrTemperatures[<%=a%>]='<%=arrTemperatures[a]%>';
	arrLat[<%=a%>]='<%=arrLat[a]%>';
	arrLog[<%=a%>]='<%=arrLog[a]%>';
	<%}%>
     	
	   for(let i=0;i<300;i++){
		   
		   
		   var position =  new kakao.maps.LatLng(arrLat[i],arrLog[i]);
		   
		       var temInt = arrTemperatures[i];
			   //마커 이미지 경로
			   /*
			   if(temInt<16)var imageSrc = "resources/img/진한파랑.png";
			   else if(temInt>=16&&temInt<17)var imageSrc = "resources/img/파랑.png";
			   else if(temInt>=17&&temInt<19)var imageSrc = "resources/img/하늘.png";
			   else if(temInt>=19&&temInt<21)var imageSrc = "resources/img/하늘.png";
			   else if(temInt>=21&&temInt<23)var imageSrc = "resources/img/연연빨강.png";
			   else if(temInt>=23&&temInt<25)var imageSrc = "resources/img/연연빨강.png";
			   else if(temInt>=25&&temInt<27)var imageSrc = "resources/img/연한빨강.png";
			   else if(temInt>=27&&temInt<29)var imageSrc = "resources/img/연한빨강.png";
			   else if(temInt>=29&&temInt<31)var imageSrc = "resources/img/빨강.png";
			   else if(temInt>=31&&temInt<33)var imageSrc = "resources/img/빨강.png";
			   else if(temInt>=33&&temInt<35)var imageSrc = "resources/img/빨강.png";
			   else if(temInt>=35&&temInt<40)var imageSrc = "resources/img/진한빨강.png";
			   else if(temInt>=40)var imageSrc = "resources/img/진한빨강.png";
			   */
			   
			   if(temInt<16)var imageSrc = "resources/img/15도.png";
			   else if(temInt>=16&&temInt<17)var imageSrc = "resources/img/16도.png";
			   else if(temInt>=17&&temInt<19)var imageSrc = "resources/img/17~18도.png";
			   else if(temInt>=19&&temInt<21)var imageSrc = "resources/img/19~20도.png";
			   else if(temInt>=21&&temInt<23)var imageSrc = "resources/img/21~22도.png";
			   else if(temInt>=23&&temInt<25)var imageSrc = "resources/img/23~24도.png";
			   else if(temInt>=25&&temInt<27)var imageSrc = "resources/img/25~26도.png";
			   else if(temInt>=27&&temInt<29)var imageSrc = "resources/img/27~28도.png";
			   else if(temInt>=29&&temInt<31)var imageSrc = "resources/img/29~30도.png";
			   else if(temInt>=31&&temInt<33)var imageSrc = "resources/img/31~32도.png";
			   else if(temInt>=33&&temInt<35)var imageSrc = "resources/img/33~34도.png";
			   else if(temInt>=35&&temInt<40)var imageSrc = "resources/img/35~39도.png";
			   else if(temInt>=40)var imageSrc = "resources/img/40도~.png";
			    
			    // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new kakao.maps.Size(24, 24); 
			    // 마커 이미지를 생성합니다    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			 	// 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        position: position,
			        image : markerImage, //마커 이미지
			        clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
			    });
			 	// 마커를 지도에 표시합니다.
			    marker.setMap(map);
			 	
			    // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			    var iwContent = '<div style="padding: 5px 0 0 10px;margin-right: 5px;width: 286px;height: 65px;">'+arrTime[i]+'/'+arrArea[i]+'/'+arrTemperatures[i]+"ºC"+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    //var iwContent = '<div style="padding:5px;">Hello World!</div>',    
			    	iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			    // 인포윈도우를 생성합니다
			    var infowindow = new kakao.maps.InfoWindow({
			        content : iwContent,
			        removable : iwRemoveable
			    });
			    
			    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
			    
			    function makeClickListener(map, marker, infowindow) {
			    return function() {
			    infowindow.open(map, marker);
			    };
			    }

		   }

   <%}%>
   
</script>
<script>
function typechange(){
  var datelist = document.getElementById("datelist").value;
  
  var dateArray = datelist.split('-');
  (yearNum).setAttribute("value",dateArray[0]);
  (monthNum).setAttribute("value",dateArray[1]);
  (dayNum).setAttribute("value",dateArray[2]);
  
  $("#yearNum").html(dateArray[0]+"년");//클릭한 위치의 option 텍스트를 변경합니다.
  $("#monthNum").html(dateArray[1]+"월");//클릭한 위치의 option 텍스트를 변경합니다.
  $("#dayNum").html(dateArray[2]+"일");//클릭한 위치의 option 텍스트를 변경합니다.
  
  $("#year option:eq(0)").prop("selected", true); //첫번째 option 선택
  $("#month option:eq(0)").prop("selected", true); //첫번째 option 선택
  $("#day option:eq(0)").prop("selected", true); //첫번째 option 선택
  
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
<script src="https://code.jquery.com/jquery-3.1.1,min.js"></script>
<srcipt scr="js/bootstrap.js"></srcipt>
</body>
</html>