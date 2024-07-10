package kr.or.connect.heatmap.dto;

import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;

public class SetTimeData {
	private Date dateSet;
	private String timeString;
	private Time timeSet;

	public Date getDateSet() {
		return dateSet;
	}

	public void setDateSet(Date dateSet) {
		this.dateSet = dateSet;
	}

	public String getTimeString() {
		return timeString;
	}

	public void setTimeString(String timeString) {
		this.timeString = timeString+":00";
		this.timeSet = java.sql.Time.valueOf(this.timeString);
	}

	public Time getTimeSet() {
		return timeSet;
	}

	public void setTimeSet(Time timeSet) {
		this.timeSet = timeSet;
	}
}
