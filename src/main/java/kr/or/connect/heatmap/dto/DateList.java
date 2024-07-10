package kr.or.connect.heatmap.dto;

public class DateList {
   private java.sql.Date date;
   private float temperatures;

   public java.sql.Date getDate() {
      return date;
   }

   public void setDate(java.sql.Date date) {
      this.date = date;
   }
   
   public float getTemperatures() {
      return temperatures;
   }

   public void setTemperatures(float temperatures) {
      this.temperatures = temperatures;
   }

}