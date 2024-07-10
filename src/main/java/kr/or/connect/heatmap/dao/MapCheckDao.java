package kr.or.connect.heatmap.dao;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import kr.or.connect.heatmap.dto.DateList;
import kr.or.connect.heatmap.dto.MapCheckData;
import kr.or.connect.heatmap.dto.pastSurveyFormData;

@Repository
public class MapCheckDao {
	private NamedParameterJdbcTemplate jdbc;
	   private SimpleJdbcInsert insertAction;
	   private RowMapper<MapCheckData> rowMapper = BeanPropertyRowMapper.newInstance(MapCheckData.class);
	   private RowMapper<DateList> rowMapperStr = BeanPropertyRowMapper.newInstance(DateList.class);
	   
	   public MapCheckDao(DataSource dataSource) {
	      this.jdbc = new NamedParameterJdbcTemplate(dataSource);
	      
	      this.insertAction = new SimpleJdbcInsert(dataSource)
	                .withTableName("surveyform");//table 명
	   }
	   
	   public List<DateList> dateList(){
	       String sql="SELECT DISTINCT date FROM SURVEYFORM ORDER BY date DESC";
	       
	       return jdbc.query(sql, Collections.emptyMap(), rowMapperStr);    
	    }
	   
	    public List<MapCheckData> selectAll(String year, String month, String day) {
	      
	      String sql = "SELECT * FROM surveyform where date LIKE '"+year+"-"+month+"-"+day+"'";
	      
	      return jdbc.query(sql, Collections.emptyMap(), rowMapper);
	    }
    
    public List<MapCheckData> selectAllPast(String year, String month, String day) {
		String sql = "SELECT date,time,area1,temperatures,latitude,longitude FROM surveyform where date LIKE '"+year+"-"+month+"-"+day+"'";
		return jdbc.query(sql, Collections.emptyMap(), rowMapper);
    }
    public List<MapCheckData> selectAllDay() {
		String sql = "select distinct date from surveyform";
		return jdbc.query(sql, Collections.emptyMap(), rowMapper);
    }

}
