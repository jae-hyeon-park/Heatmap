package kr.or.connect.heatmap.dao;

import java.sql.Date;
import java.sql.Time;
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

import kr.or.connect.heatmap.dto.SetTimeData;
import kr.or.connect.heatmap.dto.SetTimeData;

@Repository
public class SetTimeDao {
	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<SetTimeData> rowMappersetTime = BeanPropertyRowMapper.newInstance(SetTimeData.class);
	
	public SetTimeDao(DataSource dataSource) {
		this.jdbc = new NamedParameterJdbcTemplate(dataSource);
		
		this.insertAction = new SimpleJdbcInsert(dataSource)
                .withTableName("settime");//table 명
	}
	
	public int insert(SetTimeData data) { //id까지 넣음
		SqlParameterSource params = new BeanPropertySqlParameterSource(data);
		
		return insertAction.execute(params);
	}
	
	public List<SetTimeData> setTimeList(){
		String sql = "SELECT * FROM settime ORDER BY date_set";
		
		return jdbc.query(sql, Collections.emptyMap(), rowMappersetTime);
	}
	
	public int deleteSetTime(Date dateSet) {
		String sql = "DELETE FROM settime WHERE date_set<:dateSet";
		
		Map<String, Object> params = new HashMap<>();
	    params.put("dateSet", dateSet);
		
		return jdbc.update(sql, params);
	}
	
	public int getCount() {
		String sql = "SELECT COUNT(*) FROM settime";
		return jdbc.queryForObject(sql, Collections.emptyMap(), Integer.class);
	}
	
	public List<SetTimeData> timeCheckList(Date dateSet){
		String sql = "SELECT * FROM settime WHERE date_set = :dateSet";
		Map<String, Object> params = new HashMap<>();
	    params.put("dateSet", dateSet);
	    return jdbc.query(sql, params, rowMappersetTime);
	}
	
	public int getTimeCheckListCount(Date dateSet) {
		String sql = "SELECT COUNT(*) FROM settime WHERE date_set = :dateSet";
		Map<String, Object> params = new HashMap<>();
	    params.put("dateSet", dateSet);
		return jdbc.queryForObject(sql, params, Integer.class);
	}
	
	public int deleteButton(Date dateSet, Time timeSet) {
		String sql = "DELETE FROM settime WHERE date_set = :dateSet and time_set = :timeSet";
		
		Map<String, Object> params = new HashMap<>();
	    params.put("dateSet", dateSet);
	    params.put("timeSet", timeSet);
		
		return jdbc.update(sql, params);
	}
	public int deleteAll() {
		String sql = "DELETE FROM settime ";
		
		Map<String, Object> params = new HashMap<>();
	    
		
		return jdbc.update(sql, params);
	}
}
