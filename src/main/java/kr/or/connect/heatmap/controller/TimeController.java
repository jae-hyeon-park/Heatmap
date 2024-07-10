package kr.or.connect.heatmap.controller;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.or.connect.heatmap.config.ApplicationConfig;
import kr.or.connect.heatmap.dao.SetTimeDao;
import kr.or.connect.heatmap.dto.SetTimeData;

@Controller
public class TimeController {
	
	@GetMapping("/setTime")
	public String timeSetting(Model model) {
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		SetTimeDao settimedao = ac.getBean(SetTimeDao.class);
		
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		
		settimedao.deleteSetTime(sqlDate);
		
		List<SetTimeData> settimedata = null;
		settimedata = settimedao.setTimeList();
		
		/*List<String> datedata = new ArrayList<String>();
		List<String> timedata = new ArrayList<String>();
		
		System.out.println(settimedao.getCount());
		for (int i = 0; i < settimedao.getCount(); i++) {
			java.util.Date utilDate = new java.sql.Date(settimedata.get(i).getDateSet().getTime());
	        Date from = settimedata.get(i).getDateSet();
	        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	        String to = transFormat.format(utilDate);
	        datedata.add(to);
		}
			
		for (int i = 0; i < settimedao.getCount(); i++) {
			java.sql.Timestamp utilTime = new java.sql.Timestamp(settimedata.get(i).getTimeSet().getTime());
			SimpleDateFormat transFormat = new SimpleDateFormat("HH:mm:ss");
			String to = transFormat.format(utilTime);
	        
	        timedata.add(to);
		}*/
		
		model.addAttribute("setdata", settimedata);
		//model.addAttribute("datedata", datedata);
		//model.addAttribute("timedata", timedata);
		
		return "setTime";
	}
	
	@PostMapping("/setTime")
	public String timeSet(@ModelAttribute SetTimeData data, Model model) {
		
		System.out.println("//////");
		System.out.println(data.getDateSet());
		System.out.println(data.getTimeString());
		System.out.println(data.getTimeSet());
		
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		SetTimeDao settimedao = ac.getBean(SetTimeDao.class);
		
		settimedao.insert(data);
		
		List<SetTimeData> settimedata = null;
		settimedata = settimedao.setTimeList();
		model.addAttribute("setdata", settimedata);
		
		return "setTime";
	}
	
	@PostMapping("/deleteTime")
	public String deleteTimeSet(@ModelAttribute SetTimeData data, Model model) {
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		SetTimeDao settimedao = ac.getBean(SetTimeDao.class);
		
		settimedao.deleteButton(data.getDateSet(), data.getTimeSet());
		
		List<SetTimeData> settimedata = null;
		settimedata = settimedao.setTimeList();
		model.addAttribute("setdata", settimedata);
		
		return "setTime";
	}
	@PostMapping("/deleteAll")
	public String deleteTimeAll(@ModelAttribute SetTimeData data, Model model) {
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		SetTimeDao settimedao = ac.getBean(SetTimeDao.class);
		
		settimedao.deleteAll();
		
		List<SetTimeData> settimedata = null;
		settimedata = settimedao.setTimeList();
		model.addAttribute("setdata", settimedata);
		
		return "setTime";
	}
}
