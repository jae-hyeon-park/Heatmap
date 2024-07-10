package kr.or.connect.heatmap.dto;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.DecimalFormat; //decimal쓸떼 필요할수도?
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import kr.or.connect.heatmap.config.*;
import kr.or.connect.heatmap.dao.HeatMapFormDao;
import kr.or.connect.heatmap.dto.HeatMapFormData;

public class MapCheckData {
	private Date date;
	private int assignmentNum;
	private String area1;
	private String namefull;

	private float temperatures;
	private String weather;


	private Time time;
	private String filename1;


	private String id;   //id추가
	private double longitude; //위도
	private double latitude; // 경도
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getAssignmentNum() {
		return assignmentNum;
	}
	public void setAssignmentNum(int assignmentNum) {
		this.assignmentNum = assignmentNum;
	}
	public String getArea1() {
		return area1;
	}
	public void setArea1(String area1) {
		this.area1 = area1;
	}
	public String getNamefull() {
		return namefull;
	}
	public void setNamefull(String namefull) {
		this.namefull = namefull;
	}
	public float getTemperatures() {
		return temperatures;
	}
	public void setTemperatures(float temperatures) {
		this.temperatures = temperatures;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public String getFilename1() {
		return filename1;
	}
	public void setFilename1(String filename1) {
		this.filename1 = filename1;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	@Override
	public String toString() {
		return "MapCheckData [date=" + date + ", assignmentNum=" + assignmentNum + ", area1=" + area1 + ", namefull="
				+ namefull + ", temperatures=" + temperatures + ", weather=" + weather + ", time=" + time
				+ ", filename1=" + filename1 + ", id=" + id + ", longitude=" + longitude + ", latitude=" + latitude
				+ "]";
	}



}
