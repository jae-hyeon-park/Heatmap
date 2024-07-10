package kr.or.connect.heatmap.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.connect.heatmap.config.ApplicationConfig;

import kr.or.connect.heatmap.dao.MapCheckDao;
import kr.or.connect.heatmap.dao.SetTimeDao;
import kr.or.connect.heatmap.dto.DateList;
import kr.or.connect.heatmap.dto.HeatMapFormData;
import kr.or.connect.heatmap.dto.MapCheckData;
import kr.or.connect.heatmap.dto.SetTimeData;
import kr.or.connect.heatmap.dto.pastSurveyFormData;


@Controller
public class MapCheck {
	
	//열지도 보기 페이지
	   @GetMapping("/mapCheck")
	   public String joina(Model model) {
	      ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
	      MapCheckDao mapcheck = ac.getBean(MapCheckDao.class); 
	      //java.sql.Date sqlDate = new java.sql.Date();
	      List<DateList> dateParse = null;
	      dateParse = mapcheck.dateList();
	      List<String> dateList= new ArrayList<String>();

	      for(int i=0;i<dateParse.size();i++) {
	         java.util.Date utilDate = new java.sql.Date(dateParse.get(i).getDate().getTime());
	         Date from = dateParse.get(i).getDate();
	          SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	          String to = transFormat.format(utilDate);
	         dateList.add(to);
	      }
	      
	      model.addAttribute("dateList",dateList);
	       return "mapCheck";
	   }
   // 현재 위치를 받아서 보는 페이지
   @GetMapping("/myLocation")
   public String myLocation(HttpServletResponse response) {
	   ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
	   SetTimeDao settimedao = ac.getBean(SetTimeDao.class);
	   
	   response.setContentType("text/html; charset=UTF-8");
	   PrintWriter script = null;
	   try {
		   script = response.getWriter();
	   } catch (IOException e1) {
		   // TODO Auto-generated catch block
		   e1.printStackTrace();
	   }
	   
	   TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
	   java.util.Date utilDate = new java.util.Date();
	   java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	   
	   List<SetTimeData> settimedata = null;
	   settimedata = settimedao.setTimeList();
	   
	   int checkPoint = -1;
	   
	   for (int i = 0; i < settimedao.getCount(); i++) {
		   Date data1 = settimedata.get(i).getDateSet();
	       SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	       String to1 = transFormat.format(data1);
	       
	       String to2 = transFormat.format(sqlDate);
		   
	       if(to2.equals(to1)) {
	    	   checkPoint = 1;
			   System.out.println("같은 날이 있다..");
			   List<SetTimeData> timelist =settimedao.timeCheckList(data1);
			   for(int j = 0; j < settimedao.getTimeCheckListCount(data1);j++) {
				   java.util.Date Date1 = new java.sql.Date(settimedata.get(i).getDateSet().getTime());
				   java.sql.Timestamp Time1 = new java.sql.Timestamp(timelist.get(j).getTimeSet().getTime());
				   SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
				   //timeFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));, Locale.KOREA
				   String timeStr = timeFormat.format(Time1);
				   String dateStr = transFormat.format(Date1);
				   
				   String setStr = dateStr+" "+timeStr;
				   String finishStr = null;
				   
				   try {
					   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					   java.util.Date dateTime=dateFormat.parse(setStr);
					   
					   String utilDateStr = dateFormat.format(utilDate);
					   utilDate = dateFormat.parse(utilDateStr);
					   
					   Calendar cal = Calendar.getInstance();
					   cal.setTime(dateTime);
					   cal.add(Calendar.MINUTE, 30);
					   
					   finishStr = dateFormat.format(cal.getTime());
					   java.util.Date finishTime = dateFormat.parse(finishStr);
					   
					   boolean after = utilDate.after(dateTime);
					   boolean before = utilDate.before(finishTime);
					   System.out.println(dateTime+" "+finishTime);
					   System.out.println(utilDate);
					   System.out.println(before+" "+after);
					   if(before && after) {
						   break;
					   } else if(j+1 == settimedao.getTimeCheckListCount(data1)){
						   script.println("<script>alert('측정 시간이 아닙니다.');location.href = '/heatmap/'; </script>");
						   script.close();
					   }
					   
				   } catch (ParseException e) {
					   e.printStackTrace();
				   }
			   }
		   }
	   }
	   
	   if(checkPoint == -1) {
		   script.println("<script>alert('측정 시간이 아닙니다.');location.href = '/heatmap/'; </script>");
		   script.close();
	   }
	   
	   return "myLocation";
   }

// 검색기능
   @PostMapping("/MapC")
   public String uploadCheck(Model model,HttpServletRequest request) {
      ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
      MapCheckDao mapcheck = ac.getBean(MapCheckDao.class); 
      //java.sql.Date sqlDate = new java.sql.Date();
      List<DateList> dateParse = null;
      dateParse = mapcheck.dateList();
      List<String> dateList= new ArrayList<String>();

      for(int i=0;i<dateParse.size();i++) {
         java.util.Date utilDate = new java.sql.Date(dateParse.get(i).getDate().getTime());
         Date from = dateParse.get(i).getDate();
          SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
          String to = transFormat.format(utilDate);
         dateList.add(to);
      }

      model.addAttribute("dateList",dateList);
      model.addAttribute("year",request.getParameter("year"));
      model.addAttribute("month",request.getParameter("month"));
      model.addAttribute("day",request.getParameter("day"));
      return "mapCheck";
   }
   
   // 현재위치 받은 정보를 응답폼쪽으로 이동
   @PostMapping("/myLocation")
   public String uploadCheck(@ModelAttribute("data") MapCheckData data, HttpServletRequest request, HttpServletResponse response) throws Exception {
	   response.setContentType("text/html; charset=UTF-8");
	   PrintWriter script = response.getWriter();
	   
       String latitude = request.getParameter("latitude");
       String longitude  = request.getParameter("longitude");
       String MyAddress  = request.getParameter("MyAddress");
       data.setArea1(MyAddress);
       System.out.println("위도 : " + latitude);
       System.out.println("경도 : " + longitude);
       System.out.println("주소 : " + MyAddress);
       if(latitude.equals("0.0")||longitude.equals("0.0")) {
			script.println("<script>alert('현재위치가 잘못 측정되었습니다.'); history.back();</script>");
			script.close();
       }
       
      return "surveyform";
   
   }


}