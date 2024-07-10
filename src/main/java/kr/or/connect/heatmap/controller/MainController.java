package kr.or.connect.heatmap.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.connect.heatmap.config.ApplicationConfig;
import kr.or.connect.heatmap.dao.ChartDao;
import kr.or.connect.heatmap.dto.DateList;

@Controller
public class MainController {
   @GetMapping("/")
   public String mainChart(Model model, HttpServletRequest request) {
      ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
      ChartDao chart = ac.getBean(ChartDao.class);

      List<DateList> dateParse = null;
      dateParse = chart.dateList();
      System.out.println(dateParse.get(1).getDate());

      List<DateList> max = null;
      max = chart.temperaturesMaxList();
      System.out.println(max.get(1).getTemperatures());

      List<DateList> min = null;
      min = chart.temperaturesMinList();
      
      List<DateList> avg = null; //추가
      avg = chart.temperaturesAvgList();//추가

      List<String> dateList = new ArrayList<String>();
      List<String> temperaturesMax = new ArrayList<String>();
      List<String> temperaturesMin = new ArrayList<String>();
      List<String> temperaturesAvg = new ArrayList<String>(); //추가

      for (int i = 0; i < dateParse.size(); i++) {
         java.util.Date utilDate = new java.sql.Date(dateParse.get(i).getDate().getTime());
         Date from = dateParse.get(i).getDate();
         SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
         String to = transFormat.format(utilDate);
         System.out.println(to);
         dateList.add(to);
      }
      
      for (int i = 0; i < avg.size(); i++) {//추가

          float tem = avg.get(i).getTemperatures();
          String to = Float.toString(tem);
          System.out.println(tem);
          temperaturesAvg.add(to);
       }

      for (int i = 0; i < max.size(); i++) {

         float tem = max.get(i).getTemperatures();
         String to = Float.toString(tem);
         System.out.println(tem);
         temperaturesMax.add(to);
      }

      for (int i = 0; i < min.size(); i++) {

         float tem = min.get(i).getTemperatures();
         String to = Float.toString(tem);
         System.out.println(tem);
         temperaturesMin.add(to);
      }

      model.addAttribute("dateList", dateList);
      model.addAttribute("temperaturesMax", temperaturesMax);
      model.addAttribute("temperaturesMin", temperaturesMin);
      model.addAttribute("temperaturesAvg", temperaturesAvg);//추가

      return "main";
   }
}