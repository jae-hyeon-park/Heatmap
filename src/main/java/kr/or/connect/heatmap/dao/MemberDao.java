package kr.or.connect.heatmap.dao;

import java.util.Collections;
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

import kr.or.connect.heatmap.dto.HeatMapFormData;
import kr.or.connect.heatmap.dto.Member;

@Repository
public class MemberDao  {

	private NamedParameterJdbcTemplate jdbc;
	private SimpleJdbcInsert insertAction;
	private RowMapper<Member> rowMapper2 = BeanPropertyRowMapper.newInstance(Member.class);

	public MemberDao(DataSource dataSource) {
		this.jdbc = new NamedParameterJdbcTemplate(dataSource);
		
		this.insertAction = new SimpleJdbcInsert(dataSource)
                .withTableName("member");//table 명
	}
	
	public int insert2(Member memberdata, String mtype) { //회원가입
		memberdata.setMtype(mtype);
		SqlParameterSource params = new BeanPropertySqlParameterSource(memberdata);
		return insertAction.execute(params);
		}
	
	
	public List<Member> selectAll(){
		String sql = "SELECT * FROM member";
		return jdbc.query(sql, Collections.emptyMap(), rowMapper2);
		//바인딩 값을 전달할 목적 22
		//select 한건 한건의 결과를 dto에 저장하는 목적 33 beanpropertyrowmapper를 이용해 컬럼 값을 dto에 자동으로 담음
	}
	public int update(Member memberdata) {
		String sql =  "UPDATE member SET password = :password WHERE id = :id";  //password변경에서 탐색은 해당 id로
		SqlParameterSource params = new BeanPropertySqlParameterSource(memberdata);
		return jdbc.update(sql, params);
	}
	public int delete(String id) {
		String sql =  "DELETE FROM member WHERE id = :id";  //password변경에서 탐색은 해당 id로
		Map<String, ?> params = Collections.singletonMap("id", id);  //싱글턴으로 하나만 해서 각 객체를 만들필요가 없음?
		return jdbc.update(sql, params);
	}

	
	
	
}
