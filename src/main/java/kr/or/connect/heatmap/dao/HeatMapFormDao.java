package kr.or.connect.heatmap.dao;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import kr.or.connect.heatmap.dto.HeatMapFormData;

@Repository
public class HeatMapFormDao {
	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<HeatMapFormData> rowMapper = BeanPropertyRowMapper.newInstance(HeatMapFormData.class);
	
	public HeatMapFormDao(DataSource dataSource) {
		this.jdbc = new NamedParameterJdbcTemplate(dataSource);
		
		this.insertAction = new SimpleJdbcInsert(dataSource)
                .withTableName("surveyform");//table 명
	}
	
	public int insert(HeatMapFormData formdata) { //id까지 넣음
		
		SqlParameterSource params = new BeanPropertySqlParameterSource(formdata);
		int check= checkdata(formdata);
		if(check >= 1) {
			return -1;
		}
		return insertAction.execute(params);
	}
	
	//입력한 날짜의 배정번호가 데이터베이스에 이미 작성된 번호인지 확인하는 용도.
	public int checkdata(HeatMapFormData formdata) {
		String sql="SELECT COUNT(*) FROM surveyform WHERE date= '"+formdata.getDate()+"'AND assignment_num='"+formdata.getAssignmentNum()+"'";
		return jdbc.queryForObject(sql, Collections.emptyMap(), Integer.class);
	}
	
	public int getIdCount(int idNum) {
		String sql = "SELECT COUNT(*) FROM surveyform where id_num=:idNum ORDER BY date DESC ";
		Map<String, Object> params = new HashMap<>();
	    params.put("idNum", idNum);
		return jdbc.queryForObject(sql, params, Integer.class);
	}
	
	public int getSearchCount(String s_type, String s_value) {
		s_type = s_type==null?"":s_type.trim();
		s_value = s_value==null?"":s_value.trim();
		
		String sql = "SELECT COUNT(*) FROM surveyform";
		String where = "";
		if("1".equals(s_type)) {
			//where = "where date_format(date, '%Y%m%d') = '"+s_value+"'";
			where = "where date like '%"+s_value+"%' ORDER BY date DESC";
		}else if("2".equals(s_type)) {
			where = "where area1 like '%"+s_value+"%' ORDER BY date DESC";
		}else if("3".equals(s_type)) {
			where = "where assignment_num like '"+s_value+"' ORDER BY date DESC";
		}else if("4".equals(s_type)) {
			where = "where id like '%"+s_value+"%' ORDER BY date DESC";
		}
		
		sql = sql + " " + where;
		Map<String, Object> params = new HashMap<>();
	    //params.put("id", id);
		return jdbc.queryForObject(sql, params, Integer.class);
	}
	
	//페이징용
	public List<HeatMapFormData> selectMyId(int startRow,int endRow,String id, int idNum) {
		int limit=10;
		String sql="SELECT * FROM surveyform where id = :id AND id_num = :idNum ORDER BY date DESC limit :startRow, :limit";
		Map<String, Object> params = new HashMap<>();
		params.put("startRow", startRow);
		//params.put("endRow", endRow);
		params.put("limit", limit);
		params.put("id", id);
		params.put("idNum", idNum);
		
		return jdbc.query(sql ,params, rowMapper);
	}
	
	public List<HeatMapFormData> selectAll(){
		String sql = "SELECT * FROM surveyform ORDER BY date DESC";
		return jdbc.query(sql, Collections.emptyMap(), rowMapper);
		//바인딩 값을 전달할 목적 22
		//select 한건 한건의 결과를 dto에 저장하는 목적 33 beanpropertyrowmapper를 이용해 컬럼 값을 dto에 자동으로 담음
	}

	//jsp단에서 자신의 측정기록 가져오는 메소드
	public List<HeatMapFormData> selectIdAll(String id){
		String sql = "SELECT * FROM surveyform where id= '"+id+"' ORDER BY date DESC ";
	    Map<String, Object> params = new HashMap<>();
	    params.put("id", id);
	    return jdbc.query(sql, params, rowMapper);
	}
	
	public List<HeatMapFormData> selectForSearch(String s_type, String s_value){
		//게시판 검색 부분
		s_type = s_type==null?"":s_type.trim();
		s_value = s_value==null?"":s_value.trim();
		
		String sql = "SELECT * FROM surveyform";
		
		String where = "";
		if("1".equals(s_type)) {
			//where = "where date_format(date, '%Y%m%d') = '"+s_value+"'";
			where = "where date like '%"+s_value+"%' ORDER BY date DESC";
		}else if("2".equals(s_type)) {
			where = "where area1 like '%"+s_value+"%' ORDER BY date DESC";
		}else if("3".equals(s_type)) {
			where = "where assignment_num like '"+s_value+"' ORDER BY date DESC";
		}else if("4".equals(s_type)) {
			where = "where id like '%"+s_value+"%' ORDER BY date DESC";
		}
		
		sql = sql + " " + where;
		System.out.println(sql);
		
		return jdbc.query(sql, Collections.emptyMap(), rowMapper);
		//바인딩 값을 전달할 목적 22
		//select 한건 한건의 결과를 dto에 저장하는 목적 33 beanpropertyrowmapper를 이용해 컬럼 값을 dto에 자동으로 담음
	}
	
	//페이징용
	public List<HeatMapFormData> selectSearchList(String s_type, String s_value, int startRow){
		//게시판 검색 부분
		s_type = s_type==null?"":s_type.trim();
		s_value = s_value==null?"":s_value.trim();
		
		Map<String, Object> params = new HashMap<>();
		//String sql=null;
		String sql = "SELECT * FROM surveyform";
		int limit=10;
		
		String where = "";
		if("1".equals(s_type)) {
			//where = "where date_format(date, '%Y%m%d') = '"+s_value+"'";
			where = "where date like '%"+s_value+"%' ORDER BY date DESC limit :startRow, :limit";
		}else if("2".equals(s_type)) {
			where = "where area1 like '%"+s_value+"%' ORDER BY date DESC limit :startRow, :limit";
		}else if("3".equals(s_type)) {
			where = "where assignment_num like '"+s_value+"' ORDER BY date DESC limit :startRow, :limit";
		}else if("4".equals(s_type)) {
			where = "where id like '%"+s_value+"%' ORDER BY date DESC limit :startRow, :limit";
		}else {
			where="ORDER BY date DESC limit :startRow, :limit";
		}
		
		sql = sql + " " + where;
		System.out.println(sql);
		//sql=select;
		params.put("startRow", startRow);
		params.put("limit", limit);
		
		return jdbc.query(sql, params, rowMapper);
		//바인딩 값을 전달할 목적 22
		//select 한건 한건의 결과를 dto에 저장하는 목적 33 beanpropertyrowmapper를 이용해 컬럼 값을 dto에 자동으로 담음
	}
}
