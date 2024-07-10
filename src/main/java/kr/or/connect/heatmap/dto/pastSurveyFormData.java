package kr.or.connect.heatmap.dto;

import java.sql.Date;

public class pastSurveyFormData {
	private Date date;
	private String area1;
	private float temperatures;
	private double longitude; //위도
	private double latitude; // 경도

	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getArea1() {
		return area1;
	}
	public void setArea1(String area1) {
		this.area1 = area1;
	}
	public float getTemperatures() {
		return temperatures;
	}
	public void setTemperatures(float temperatures) {
		this.temperatures = temperatures;
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
		return "pastSurveyFormData [date=" + date + ", area1=" + area1 + ", temperatures=" + temperatures
				+ ", longitude=" + longitude + ", latitude=" + latitude + "]";
	}
}
