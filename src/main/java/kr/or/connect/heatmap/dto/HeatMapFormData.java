package kr.or.connect.heatmap.dto;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import kr.or.connect.heatmap.config.*;
import kr.or.connect.heatmap.dao.HeatMapFormDao;
import kr.or.connect.heatmap.dto.HeatMapFormData;

public class HeatMapFormData {

	private Date date;
	private int assignmentNum;
	private String area1;
	private String namefull;

	private float temperatures;
	private String weather;

	private Time time;
	private String filename1;

	private MultipartFile file1;

	private String encfile1;
	private int idNum;
	private String id; // id추가

	private double longitude; // 위도
	private double latitude; // 경도
	
	private String url;

	public HeatMapFormData() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));// 서버 시간설정 관계없이 한국시간이 객체에 기록
		java.util.Date utilDate = new java.util.Date();// 어디서나 한국시간으로 실제 적용되는지 확인 불가. 확인 부탁드립니다.
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
		date = sqlDate;
		time = sqlTime;
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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {//
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

	public void setTime(Time time) {//
		this.time = time;
	}

	public String getFilename1() {
		return filename1;
	}

	public void setFilename1(String filename1) {
		this.filename1 = filename1;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) throws IOException {
		this.file1 = file1;
		this.filename1 = file1.getOriginalFilename();

		Encoder encoder = Base64.getEncoder();
		this.encfile1 = new String(encoder.encode(file1.getBytes()));
	}

	public String getEncfile1() {
		return encfile1;
	}

	public void setEncfile1(String encfile1) {
		this.encfile1 = encfile1;
	}
	
	public int getIdNum() {
		return idNum;
	}

	public void setIdNum(int idNum) {
		this.idNum = idNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
