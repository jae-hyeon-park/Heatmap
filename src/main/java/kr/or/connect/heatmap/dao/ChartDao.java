package kr.or.connect.heatmap.dao;

import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import kr.or.connect.heatmap.dto.DateList;

@Repository
public class ChartDao {
   private NamedParameterJdbcTemplate jdbc;
   private SimpleJdbcInsert insertAction;
   private RowMapper<DateList> rowMapperStr = BeanPropertyRowMapper.newInstance(DateList.class);

   public ChartDao(DataSource dataSource) {
      this.jdbc = new NamedParameterJdbcTemplate(dataSource);

      this.insertAction = new SimpleJdbcInsert(dataSource).withTableName("surveyform");// table 명
   }

   public List<DateList> dateList() {
      String sql = "SELECT DISTINCT date FROM surveyform ORDER BY date DESC limit 0,7";

      return jdbc.query(sql, Collections.emptyMap(), rowMapperStr);
   }

   public List<DateList> temperaturesMaxList() {
      String sql = "SELECT date, MAX(temperatures) AS temperatures FROM surveyform GROUP BY date ORDER BY date DESC limit 0,7";

      return jdbc.query(sql, Collections.emptyMap(), rowMapperStr);
   }

   public List<DateList> temperaturesMinList() {
      String sql = "SELECT date, MIN(temperatures) AS temperatures FROM surveyform GROUP BY date ORDER BY date DESC limit 0,7";

      return jdbc.query(sql, Collections.emptyMap(), rowMapperStr);
   }
   public List<DateList> temperaturesAvgList() { ///////추가한 부분
	      String sql = "SELECT date, AVG(temperatures) AS temperatures FROM surveyform GROUP BY date ORDER BY date DESC limit 0,7";

	      return jdbc.query(sql, Collections.emptyMap(), rowMapperStr);
	   }
}